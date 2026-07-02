'use client';

import {
  MessageSquare,
  Star,
  AlertTriangle,
  CheckCircle2,
  TrendingUp,
  Building2,
  Image as ImageIcon,
  ClipboardList,
} from 'lucide-react';
import { TrendChart } from './trend-chart';
import { createClient } from '@/lib/supabase/client';
import { useState, useEffect } from 'react';

// =============================================================================
// Types
// =============================================================================

type Feedback = {
  id: string;
  sector_id: string | null;
  rating_normalized: number | null;
  status: string | null;
  moderation_status: string | null;
  is_critical: boolean | null;
  priority: boolean | null;
  created_at: string;
};

type Improvement = {
  id: string;
  title: string;
  description: string | null;
  before_photo_url: string | null;
  after_photo_url: string | null;
  published_at: string | null;
  establishment: { name: string | null; sector_id: string | null } | null;
};

const sectorColors: Record<string, string> = {
  education: 'bg-blue-100 text-blue-700',
  health: 'bg-red-100 text-red-700',
  transport: 'bg-orange-100 text-orange-700',
  administration: 'bg-purple-100 text-purple-700',
  public_admin: 'bg-purple-100 text-purple-700',
  commerce: 'bg-green-100 text-green-700',
  hospitality: 'bg-pink-100 text-pink-700',
  energy: 'bg-amber-100 text-amber-700',
  water: 'bg-cyan-100 text-cyan-700',
  telecom: 'bg-indigo-100 text-indigo-700',
};

const sectorLabels: Record<string, string> = {
  education: 'Éducation',
  health: 'Santé',
  transport: 'Transport',
  administration: 'Administration',
  public_admin: 'Administration',
  commerce: 'Commerce',
  hospitality: 'Restauration',
  energy: 'Énergie',
  water: 'Eau',
  telecom: 'Télécom',
};

// =============================================================================
// Composant principal
// =============================================================================

export default function DashboardPage() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [feedbacks, setFeedbacks] = useState<Feedback[]>([]);
  const [improvements, setImprovements] = useState<Improvement[]>([]);
  const [counts, setCounts] = useState({ establishments: 0, alerts: 0 });

  useEffect(() => {
    async function load() {
      const supabase = createClient();
      try {
        const [fbRes, impRes, estRes, alertRes] = await Promise.all([
          supabase
            .from('feedbacks')
            .select(
              'id, sector_id, rating_normalized, status, moderation_status, is_critical, priority, created_at'
            )
            .order('created_at', { ascending: false })
            .limit(1000),
          supabase
            .from('improvements')
            .select(
              'id, title, description, before_photo_url, after_photo_url, published_at, establishment:establishment_id(name, sector_id)'
            )
            .order('published_at', { ascending: false }),
          supabase
            .from('establishments')
            .select('id', { count: 'exact', head: true }),
          supabase.from('alerts').select('id', { count: 'exact', head: true }),
        ]);

        if (fbRes.error) throw fbRes.error;
        setFeedbacks((fbRes.data as Feedback[]) ?? []);
        setImprovements(((impRes.data as unknown) as Improvement[]) ?? []);
        setCounts({
          establishments: estRes.count ?? 0,
          alerts: alertRes.count ?? 0,
        });
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Erreur de chargement');
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand"></div>
      </div>
    );
  }

  // ---- KPIs calculés sur les vraies données ----
  const total = feedbacks.length;
  const rated = feedbacks.filter((f) => f.rating_normalized != null);
  const avg =
    rated.length > 0
      ? (
          rated.reduce((s, f) => s + (f.rating_normalized ?? 0), 0) /
          rated.length /
          20
        ).toFixed(1)
      : '—';
  const critical = feedbacks.filter((f) => f.is_critical || f.priority).length;
  const resolved = feedbacks.filter(
    (f) => f.status === 'resolved' || f.moderation_status === 'resolved'
  ).length;

  // ---- Évolution des 7 derniers jours (données réelles) ----
  const days: { date: string; count: number }[] = [];
  for (let i = 6; i >= 0; i--) {
    const d = new Date();
    d.setDate(d.getDate() - i);
    const key = d.toISOString().slice(0, 10);
    const label = d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
    });
    const count = feedbacks.filter(
      (f) => f.created_at?.slice(0, 10) === key
    ).length;
    days.push({ date: label, count });
  }

  const kpis = [
    { label: 'Total feedbacks', value: total, icon: MessageSquare, color: 'text-blue-600' },
    { label: 'Note moyenne', value: avg === '—' ? '—' : `${avg}/5`, icon: Star, color: 'text-amber-500' },
    { label: 'Problèmes critiques', value: critical, icon: AlertTriangle, color: 'text-red-600' },
    { label: 'Résolus', value: resolved, icon: CheckCircle2, color: 'text-green-600' },
  ];

  const statsItems = [
    { label: 'Établissements', value: counts.establishments, icon: Building2, color: 'text-blue-500' },
    { label: 'Feedbacks', value: total, icon: MessageSquare, color: 'text-amber-500' },
    { label: 'Améliorations', value: improvements.length, icon: TrendingUp, color: 'text-indigo-500' },
    { label: 'Alertes', value: counts.alerts, icon: AlertTriangle, color: 'text-red-500' },
  ];

  const formatDate = (date: string | null) => {
    if (!date) return '';
    try {
      return new Date(date).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
      });
    } catch {
      return '';
    }
  };

  const isValidImageUrl = (url: string | null) =>
    !!url && (url.startsWith('http://') || url.startsWith('https://'));

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Tableau de bord</h2>

      {error && (
        <div className="bg-red-50 text-red-700 text-sm rounded-lg p-3 border border-red-200">
          {error}
        </div>
      )}

      {/* KPIs principaux */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        {kpis.map((k) => (
          <div key={k.label} className="bg-white rounded-2xl border p-5">
            <k.icon className={k.color} size={26} />
            <div className="mt-3 text-3xl font-bold">{k.value}</div>
            <div className="text-sm text-gray-500">{k.label}</div>
          </div>
        ))}
      </div>

      {/* Statistiques détaillées */}
      <div className="bg-white rounded-2xl border p-5">
        <h3 className="font-semibold mb-4 flex items-center gap-2">
          <ClipboardList size={20} className="text-gray-600" />
          Statistiques de la base de données
        </h3>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {statsItems.map((item) => (
            <div key={item.label} className="bg-gray-50 rounded-xl p-4 text-center">
              <item.icon className={`${item.color} mx-auto mb-2`} size={24} />
              <div className="text-2xl font-bold">{item.value}</div>
              <div className="text-xs text-gray-500">{item.label}</div>
            </div>
          ))}
        </div>
      </div>

      {/* Graphique d'évolution */}
      <div className="bg-white rounded-2xl border p-5">
        <h3 className="font-semibold mb-4">Évolution (7 derniers jours)</h3>
        <TrendChart data={days} />
      </div>

      {/* Améliorations publiées */}
      <div className="bg-white rounded-2xl border p-5">
        <div className="flex items-center justify-between mb-4">
          <h3 className="font-semibold flex items-center gap-2">
            <TrendingUp size={20} className="text-green-600" />
            Améliorations publiées
          </h3>
          <span className="text-sm text-gray-400">{improvements.length} réalisées</span>
        </div>

        {improvements.length === 0 ? (
          <p className="text-sm text-gray-400 py-6 text-center">
            Aucune amélioration publiée pour le moment.
          </p>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            {improvements.map((imp) => {
              const sector = imp.establishment?.sector_id || '';
              const sectorColor = sectorColors[sector] || 'bg-gray-100 text-gray-700';
              const sectorLabel = sectorLabels[sector] || sector;
              const hasBefore = isValidImageUrl(imp.before_photo_url);
              const hasAfter = isValidImageUrl(imp.after_photo_url);

              return (
                <div key={imp.id} className="border rounded-xl p-4 hover:shadow-md transition-shadow bg-white">
                  <div className="flex items-center gap-2 flex-wrap mb-2">
                    {sectorLabel && (
                      <span className={`text-xs font-medium px-2 py-0.5 rounded ${sectorColor}`}>
                        {sectorLabel}
                      </span>
                    )}
                    {imp.establishment?.name && (
                      <span className="text-xs text-gray-500 flex items-center gap-1">
                        <Building2 size={12} />
                        {imp.establishment.name}
                      </span>
                    )}
                  </div>

                  <h4 className="font-semibold text-gray-800 text-lg">{imp.title}</h4>
                  {imp.description && (
                    <p className="text-sm text-gray-600 mt-1 line-clamp-2">{imp.description}</p>
                  )}

                  <div className="mt-3 grid grid-cols-2 gap-3">
                    {[
                      { url: imp.before_photo_url, has: hasBefore, label: 'Avant' },
                      { url: imp.after_photo_url, has: hasAfter, label: 'Après' },
                    ].map((ph) => (
                      <div key={ph.label} className="rounded-lg overflow-hidden bg-gray-100 aspect-video relative">
                        {ph.has ? (
                          // eslint-disable-next-line @next/next/no-img-element
                          <img src={ph.url!} alt={ph.label} className="w-full h-full object-cover" />
                        ) : (
                          <div className="w-full h-full flex flex-col items-center justify-center text-gray-400">
                            <ImageIcon size={24} />
                            <span className="text-xs mt-1">Pas d&apos;image</span>
                          </div>
                        )}
                        <span className="absolute bottom-1 left-1 bg-black/60 text-white text-xs px-2 py-0.5 rounded">
                          {ph.label}
                        </span>
                      </div>
                    ))}
                  </div>

                  <div className="flex items-center justify-between mt-3 pt-2 border-t border-gray-100">
                    <span className="text-xs text-gray-400">{formatDate(imp.published_at)}</span>
                    <span className="text-xs text-green-600 flex items-center gap-1">
                      <CheckCircle2 size={14} />
                      Réalisé
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
