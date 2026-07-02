'use client';

import { 
  MessageSquare, 
  Star, 
  AlertTriangle, 
  CheckCircle2, 
  TrendingUp, 
  Building2,
  Image as ImageIcon,
  Users,
  FileText,
  MessageCircle,
  ClipboardList
} from 'lucide-react';
import { TrendChart } from './trend-chart';
import { useState, useEffect } from 'react';

// =============================================================================
// DONNÉES STATIQUES (identiques aux données fallback du mobile)
// =============================================================================

const STATIC_IMPROVEMENTS = [
  {
    id: 'improvement-1',
    title: 'Rénovation de la cantine scolaire',
    description: 'La cantine du Lycée Andohalo a été entièrement rénovée avec de nouveaux équipements et plus de places assises.',
    before_photo_url: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-05T10:00:00Z',
    establishment: {
      name: 'Lycée Andohalo',
      sector_id: 'education',
    },
  },
  {
    id: 'improvement-2',
    title: 'Nouveau système de suivi des bus',
    description: 'Un écran d\'affichage en temps réel a été installé à la gare routière de Mahamasina.',
    before_photo_url: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-03T14:30:00Z',
    establishment: {
      name: 'Gare routière de Mahamasina',
      sector_id: 'transport',
    },
  },
  {
    id: 'improvement-3',
    title: 'Réduction du temps d\'attente',
    description: 'Le CHU Joseph Ravoahangy a recruté 5 nouveaux infirmiers pour réduire le temps d\'attente.',
    before_photo_url: 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-29T09:15:00Z',
    establishment: {
      name: 'CHU Joseph Ravoahangy',
      sector_id: 'health',
    },
  },
  {
    id: 'improvement-4',
    title: 'Modernisation du marché',
    description: 'Le Marché d\'Andravoahangy a été modernisé avec de nouveaux étals et un système de prix affichés.',
    before_photo_url: 'https://images.unsplash.com/photo-1556909114-44e7eef05324?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1556909114-44e7eef05324?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-01T11:45:00Z',
    establishment: {
      name: 'Marché d\'Andravoahangy',
      sector_id: 'commerce',
    },
  },
  {
    id: 'improvement-5',
    title: 'Nouveau système de gestion des déchets',
    description: 'La Mairie d\'Antananarivo a mis en place un nouveau système de collecte des déchets.',
    before_photo_url: 'https://images.unsplash.com/photo-1532996122725-e3c354a0b15b?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1532996122725-e3c354a0b15b?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-07T08:00:00Z',
    establishment: {
      name: 'Mairie d\'Antananarivo',
      sector_id: 'administration',
    },
  },
  {
    id: 'improvement-6',
    title: 'Amélioration de l\'accès à l\'eau potable',
    description: 'Installation de 3 nouveaux points d\'eau potable dans le quartier d\'Andohalo.',
    before_photo_url: 'https://images.unsplash.com/photo-1544829099-b9a0c074d091?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1544829099-b9a0c074d091?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-31T13:20:00Z',
    establishment: {
      name: 'Service des Eaux',
      sector_id: 'water',
    },
  },
  {
    id: 'improvement-7',
    title: 'Installation de l\'éclairage public',
    description: 'Nouveaux lampadaires solaires installés dans les quartiers périphériques.',
    before_photo_url: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-28T16:40:00Z',
    establishment: {
      name: 'Mairie d\'Antananarivo',
      sector_id: 'administration',
    },
  },
  {
    id: 'improvement-8',
    title: 'Rénovation du terrain de sport',
    description: 'Le terrain de sport du Lycée Andohalo a été entièrement rénové avec un nouveau gazon synthétique.',
    before_photo_url: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-26T12:00:00Z',
    establishment: {
      name: 'Lycée Andohalo',
      sector_id: 'education',
    },
  },
  {
    id: 'improvement-9',
    title: 'Nouvelle signalisation routière',
    description: 'Installation de nouveaux panneaux de signalisation dans les zones scolaires.',
    before_photo_url: 'https://images.unsplash.com/photo-1548575469-4a7e378d3e0f?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1548575469-4a7e378d3e0f?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-02T10:30:00Z',
    establishment: {
      name: 'Direction des Transports',
      sector_id: 'transport',
    },
  },
  {
    id: 'improvement-10',
    title: 'Rénovation du service de pédiatrie',
    description: 'Le service de pédiatrie du CHU a été rénové avec de nouveaux équipements.',
    before_photo_url: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-30T14:00:00Z',
    establishment: {
      name: 'CHU Joseph Ravoahangy',
      sector_id: 'health',
    },
  },
  {
    id: 'improvement-11',
    title: 'Création d\'un marché couvert',
    description: 'Construction d\'un marché couvert pour protéger les commerçants des intempéries.',
    before_photo_url: 'https://images.unsplash.com/photo-1556909114-44e7eef05324?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1556909114-44e7eef05324?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-06T09:00:00Z',
    establishment: {
      name: 'Marché d\'Anosy',
      sector_id: 'commerce',
    },
  },
  {
    id: 'improvement-12',
    title: 'Électrification rurale',
    description: 'Extension du réseau électrique à 5 villages périphériques.',
    before_photo_url: 'https://images.unsplash.com/photo-1567157577867-05ccb1388e66?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1567157577867-05ccb1388e66?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-25T11:00:00Z',
    establishment: {
      name: 'Jirama',
      sector_id: 'energy',
    },
  },
  {
    id: 'improvement-13',
    title: 'Amélioration de la connectivité internet',
    description: 'Installation de fibre optique dans les quartiers d\'affaires.',
    before_photo_url: 'https://images.unsplash.com/photo-1544197165-9d4b12f169a3?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1544197165-9d4b12f169a3?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-04T15:45:00Z',
    establishment: {
      name: 'Telma',
      sector_id: 'telecom',
    },
  },
  {
    id: 'improvement-14',
    title: 'Rénovation des toilettes publiques',
    description: 'Rénovation complète des toilettes publiques du marché d\'Andravoahangy.',
    before_photo_url: 'https://images.unsplash.com/photo-1562158953-26f8a12b9166?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1562158953-26f8a12b9166?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-08T17:00:00Z',
    establishment: {
      name: 'Marché d\'Andravoahangy',
      sector_id: 'commerce',
    },
  },
  {
    id: 'improvement-15',
    title: 'Aménagement d\'une piste cyclable',
    description: 'Création d\'une piste cyclable sécurisée le long du boulevard.',
    before_photo_url: 'https://images.unsplash.com/photo-1531065399823-36b8a1f0d22a?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1531065399823-36b8a1f0d22a?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-09T08:30:00Z',
    establishment: {
      name: 'Commune Urbaine',
      sector_id: 'transport',
    },
  },
  {
    id: 'improvement-16',
    title: 'Création d\'un jardin public',
    description: 'Aménagement d\'un jardin public avec aire de jeux pour enfants.',
    before_photo_url: 'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-10T10:00:00Z',
    establishment: {
      name: 'Mairie d\'Antananarivo',
      sector_id: 'administration',
    },
  },
  {
    id: 'improvement-17',
    title: 'Formation des enseignants',
    description: 'Programme de formation continue pour 50 enseignants du primaire.',
    before_photo_url: 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-05-27T13:00:00Z',
    establishment: {
      name: 'Lycée Andohalo',
      sector_id: 'education',
    },
  },
  {
    id: 'improvement-18',
    title: 'Nouveau système d\'irrigation',
    description: 'Installation d\'un système d\'irrigation goutte-à-goutte pour les maraîchers.',
    before_photo_url: 'https://images.unsplash.com/photo-1531908146736-33f8a37060b0?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1531908146736-33f8a37060b0?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-11T07:00:00Z',
    establishment: {
      name: 'Service des Eaux',
      sector_id: 'water',
    },
  },
  {
    id: 'improvement-19',
    title: 'Rénovation de l\'école primaire',
    description: 'Rénovation complète de l\'école primaire publique d\'Andohalo.',
    before_photo_url: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-12T09:30:00Z',
    establishment: {
      name: 'École Primaire Andohalo',
      sector_id: 'education',
    },
  },
  {
    id: 'improvement-20',
    title: 'Création d\'un centre de santé communautaire',
    description: 'Ouverture d\'un centre de santé communautaire dans le quartier d\'Ambohimanarina.',
    before_photo_url: 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=300&fit=crop',
    after_photo_url: 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=400&h=300&fit=crop&sat=-100&bright=20',
    published_at: '2024-06-13T11:15:00Z',
    establishment: {
      name: 'Ministère de la Santé',
      sector_id: 'health',
    },
  },
];

// =============================================================================
// STATISTIQUES
// =============================================================================

const STATS = {
  establishments: 30,
  templates: 10,
  feedbacks: 50,
  messages: 50,
  improvements: 20,
  total: 160,
};

// =============================================================================
// COMPOSANT PRINCIPAL
// =============================================================================

export default function DashboardPage() {
  // Simuler un chargement
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setLoading(false);
    }, 500);
    return () => clearTimeout(timer);
  }, []);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  // Données pour les KPIs
  const total = STATS.feedbacks;
  const avg = 4.2;
  const critical = 12;
  const resolved = 28;

  // Évolution simulée (7 derniers jours)
  const trend = [
    { date: '10/06', count: 8 },
    { date: '11/06', count: 12 },
    { date: '12/06', count: 5 },
    { date: '13/06', count: 15 },
    { date: '14/06', count: 7 },
    { date: '15/06', count: 10 },
    { date: '16/06', count: 13 },
  ];

  const kpis = [
    { label: 'Total feedbacks', value: total, icon: MessageSquare, color: 'text-blue-600' },
    { label: 'Note moyenne', value: `${avg}/5`, icon: Star, color: 'text-amber-500' },
    { label: 'Problèmes critiques', value: critical, icon: AlertTriangle, color: 'text-red-600' },
    { label: 'Résolus', value: resolved, icon: CheckCircle2, color: 'text-green-600' },
  ];

  // Statistiques détaillées
  const statsItems = [
    { label: 'Établissements', value: STATS.establishments, icon: Building2, color: 'text-blue-500' },
    { label: 'Templates', value: STATS.templates, icon: FileText, color: 'text-purple-500' },
    { label: 'Feedbacks', value: STATS.feedbacks, icon: MessageSquare, color: 'text-amber-500' },
    { label: 'Messages', value: STATS.messages, icon: MessageCircle, color: 'text-green-500' },
    { label: 'Améliorations', value: STATS.improvements, icon: TrendingUp, color: 'text-indigo-500' },
    { label: 'Total général', value: STATS.total, icon: ClipboardList, color: 'text-red-500' },
  ];

  type Establishment = {
    name: string;
    sector_id: string;
  };

  const getEstablishment = (imp: any): Establishment | null => {
    if (imp.establishment && typeof imp.establishment === 'object') {
      return imp.establishment as Establishment;
    }
    return null;
  };

  const sectorColors: Record<string, string> = {
    education: 'bg-blue-100 text-blue-700',
    health: 'bg-red-100 text-red-700',
    transport: 'bg-orange-100 text-orange-700',
    administration: 'bg-purple-100 text-purple-700',
    commerce: 'bg-green-100 text-green-700',
    energy: 'bg-amber-100 text-amber-700',
    water: 'bg-cyan-100 text-cyan-700',
    telecom: 'bg-indigo-100 text-indigo-700',
  };

  const sectorLabels: Record<string, string> = {
    education: 'Éducation',
    health: 'Santé',
    transport: 'Transport',
    administration: 'Administration',
    commerce: 'Commerce',
    energy: 'Énergie',
    water: 'Eau',
    telecom: 'Télécom',
  };

  const formatDate = (date: string | null) => {
    if (!date) return '';
    try {
      return new Date(date).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
      });
    } catch {
      return '';
    }
  };

  const isValidImageUrl = (url: string | null): boolean => {
    if (!url) return false;
    return url.startsWith('http://') || url.startsWith('https://');
  };

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Tableau de bord</h2>

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
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
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
        <TrendChart data={trend} />
      </div>

      {/* Toutes les améliorations */}
      <div className="bg-white rounded-2xl border p-5">
        <div className="flex items-center justify-between mb-4">
          <h3 className="font-semibold flex items-center gap-2">
            <TrendingUp size={20} className="text-green-600" />
            Toutes les améliorations
          </h3>
          <span className="text-sm text-gray-400">{STATIC_IMPROVEMENTS.length} réalisées</span>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
          {STATIC_IMPROVEMENTS.map((imp) => {
            const establishment = getEstablishment(imp);
            const sector = establishment?.sector_id || '';
            const sectorColor = sectorColors[sector] || 'bg-gray-100 text-gray-700';
            const sectorLabel = sectorLabels[sector] || sector;

            const hasBeforeImage = isValidImageUrl(imp.before_photo_url);
            const hasAfterImage = isValidImageUrl(imp.after_photo_url);

            return (
              <div key={imp.id} className="border rounded-xl p-4 hover:shadow-md transition-shadow bg-white">
                {/* En-tête avec secteur et établissement */}
                <div className="flex items-center gap-2 flex-wrap mb-2">
                  <span className={`text-xs font-medium px-2 py-0.5 rounded ${sectorColor}`}>
                    {sectorLabel}
                  </span>
                  {establishment?.name && (
                    <span className="text-xs text-gray-500 flex items-center gap-1">
                      <Building2 size={12} />
                      {establishment.name}
                    </span>
                  )}
                </div>

                {/* Titre et description */}
                <h4 className="font-semibold text-gray-800 text-lg">{imp.title}</h4>
                {imp.description && (
                  <p className="text-sm text-gray-600 mt-1 line-clamp-2">{imp.description}</p>
                )}

                {/* Images Avant / Après */}
                <div className="mt-3 grid grid-cols-2 gap-3">
                  {/* Image Avant */}
                  <div className="rounded-lg overflow-hidden bg-gray-100 aspect-video relative group">
                    {hasBeforeImage ? (
                      <img
                        src={imp.before_photo_url}
                        alt="Avant"
                        className="w-full h-full object-cover"
                        onError={(e) => {
                          const target = e.target as HTMLImageElement;
                          target.style.display = 'none';
                          const parent = target.parentElement;
                          if (parent) {
                            const fallback = document.createElement('div');
                            fallback.className = 'w-full h-full flex flex-col items-center justify-center text-gray-400';
                            fallback.innerHTML = `
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>
                              <span class="text-xs mt-1">Image non disponible</span>
                            `;
                            parent.appendChild(fallback);
                          }
                        }}
                      />
                    ) : (
                      <div className="w-full h-full flex flex-col items-center justify-center text-gray-400">
                        <ImageIcon size={24} />
                        <span className="text-xs mt-1">Pas d'image</span>
                      </div>
                    )}
                    <span className="absolute bottom-1 left-1 bg-black/60 text-white text-xs px-2 py-0.5 rounded">
                      Avant
                    </span>
                  </div>

                  {/* Image Après */}
                  <div className="rounded-lg overflow-hidden bg-gray-100 aspect-video relative group">
                    {hasAfterImage ? (
                      <img
                        src={imp.after_photo_url}
                        alt="Après"
                        className="w-full h-full object-cover"
                        onError={(e) => {
                          const target = e.target as HTMLImageElement;
                          target.style.display = 'none';
                          const parent = target.parentElement;
                          if (parent) {
                            const fallback = document.createElement('div');
                            fallback.className = 'w-full h-full flex flex-col items-center justify-center text-gray-400';
                            fallback.innerHTML = `
                              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>
                              <span class="text-xs mt-1">Image non disponible</span>
                            `;
                            parent.appendChild(fallback);
                          }
                        }}
                      />
                    ) : (
                      <div className="w-full h-full flex flex-col items-center justify-center text-gray-400">
                        <ImageIcon size={24} />
                        <span className="text-xs mt-1">Pas d'image</span>
                      </div>
                    )}
                    <span className="absolute bottom-1 right-1 bg-black/60 text-white text-xs px-2 py-0.5 rounded">
                      Après
                    </span>
                  </div>
                </div>

                {/* Date et statut */}
                <div className="flex items-center justify-between mt-3 pt-2 border-t border-gray-100">
                  <span className="text-xs text-gray-400">
                    {formatDate(imp.published_at)}
                  </span>
                  <span className="text-xs text-green-600 flex items-center gap-1">
                    <CheckCircle2 size={14} />
                    Réalisé
                  </span>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}