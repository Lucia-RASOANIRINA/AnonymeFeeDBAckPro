'use client';

import { createClient } from '@/lib/supabase/client';
import { useEffect, useState } from 'react';
import { 
  MessageSquare, 
  Star, 
  AlertTriangle, 
  CheckCircle2,
  Filter,
  Search,
  X
} from 'lucide-react';

// =============================================================================
// DONNÉES STATIQUES DE SECOURS (identiques au mobile)
// =============================================================================

const STATIC_FEEDBACKS = [
  {
    id: 'fb-001',
    sector_id: 'education',
    rating_normalized: 80,
    comment: 'Très bonne école, les enseignants sont compétents et les locaux sont propres.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-06-05T10:00:00Z',
    establishment: { name: 'Lycée Andohalo' },
  },
  {
    id: 'fb-002',
    sector_id: 'health',
    rating_normalized: 40,
    comment: 'Temps d\'attente trop long et manque de personnel soignant.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-06-04T14:30:00Z',
    establishment: { name: 'CHU Joseph Ravoahangy' },
  },
  {
    id: 'fb-003',
    sector_id: 'transport',
    rating_normalized: 60,
    comment: 'La gare est propre mais les bus ne sont pas ponctuels.',
    status: 'resolved',
    priority: 0,
    is_critical: false,
    created_at: '2024-06-03T09:15:00Z',
    establishment: { name: 'Gare routière de Mahamasina' },
  },
  {
    id: 'fb-004',
    sector_id: 'administration',
    rating_normalized: 70,
    comment: 'Les services sont efficaces et les employés sont courtois.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-06-02T11:45:00Z',
    establishment: { name: 'Mairie d\'Antananarivo' },
  },
  {
    id: 'fb-005',
    sector_id: 'commerce',
    rating_normalized: 50,
    comment: 'Le marché est bien approvisionné mais les prix varient beaucoup.',
    status: 'hidden',
    priority: 0,
    is_critical: false,
    created_at: '2024-06-01T08:00:00Z',
    establishment: { name: 'Marché d\'Andravoahangy' },
  },
  {
    id: 'fb-006',
    sector_id: 'education',
    rating_normalized: 90,
    comment: 'Excellent accueil et professionnalisme du personnel.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-31T13:20:00Z',
    establishment: { name: 'Lycée Andohalo' },
  },
  {
    id: 'fb-007',
    sector_id: 'health',
    rating_normalized: 30,
    comment: 'Service médical à améliorer, manque de matériel.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-30T16:40:00Z',
    establishment: { name: 'CHU Joseph Ravoahangy' },
  },
  {
    id: 'fb-008',
    sector_id: 'transport',
    rating_normalized: 85,
    comment: 'Très bon service, bus confortables et ponctuels.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-29T12:00:00Z',
    establishment: { name: 'Gare routière de Mahamasina' },
  },
  {
    id: 'fb-009',
    sector_id: 'administration',
    rating_normalized: 45,
    comment: 'Délais trop longs pour obtenir les documents administratifs.',
    status: 'new',
    priority: 1,
    is_critical: false,
    created_at: '2024-05-28T10:30:00Z',
    establishment: { name: 'Mairie d\'Antananarivo' },
  },
  {
    id: 'fb-010',
    sector_id: 'commerce',
    rating_normalized: 75,
    comment: 'Bon rapport qualité-prix, service client agréable.',
    status: 'resolved',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-27T14:00:00Z',
    establishment: { name: 'Marché d\'Andravoahangy' },
  },
  {
    id: 'fb-011',
    sector_id: 'energy',
    rating_normalized: 35,
    comment: 'Coupures d\'électricité fréquentes dans le quartier.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-26T09:00:00Z',
    establishment: { name: 'Jirama' },
  },
  {
    id: 'fb-012',
    sector_id: 'water',
    rating_normalized: 55,
    comment: 'Qualité de l\'eau acceptable mais pression parfois faible.',
    status: 'pending',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-25T11:00:00Z',
    establishment: { name: 'Service des Eaux' },
  },
  {
    id: 'fb-013',
    sector_id: 'telecom',
    rating_normalized: 65,
    comment: 'Connexion internet instable, débit insuffisant.',
    status: 'pending',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-24T15:45:00Z',
    establishment: { name: 'Telma' },
  },
  {
    id: 'fb-014',
    sector_id: 'education',
    rating_normalized: 20,
    comment: 'Manque de matériel pédagogique et classes surchargées.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-23T17:00:00Z',
    establishment: { name: 'École Primaire Andohalo' },
  },
  {
    id: 'fb-015',
    sector_id: 'health',
    rating_normalized: 95,
    comment: 'Service d\'urgence excellent, professionnels compétents.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-22T08:30:00Z',
    establishment: { name: 'CHU Joseph Ravoahangy' },
  },
  {
    id: 'fb-016',
    sector_id: 'transport',
    rating_normalized: 25,
    comment: 'Taxi-brousse en mauvais état, sécurité non assurée.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-21T10:00:00Z',
    establishment: { name: 'Gare routière de Mahamasina' },
  },
  {
    id: 'fb-017',
    sector_id: 'administration',
    rating_normalized: 60,
    comment: 'Service correct, mais attente trop longue.',
    status: 'resolved',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-20T13:00:00Z',
    establishment: { name: 'Mairie d\'Antananarivo' },
  },
  {
    id: 'fb-018',
    sector_id: 'commerce',
    rating_normalized: 40,
    comment: 'Prix trop élevés par rapport à la qualité des produits.',
    status: 'hidden',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-19T07:00:00Z',
    establishment: { name: 'Marché d\'Andravoahangy' },
  },
  {
    id: 'fb-019',
    sector_id: 'energy',
    rating_normalized: 70,
    comment: 'Service de distribution correct, facturation transparente.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-18T09:30:00Z',
    establishment: { name: 'Jirama' },
  },
  {
    id: 'fb-020',
    sector_id: 'water',
    rating_normalized: 15,
    comment: 'Eau non potable, problèmes de santé dans le quartier.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-17T11:15:00Z',
    establishment: { name: 'Service des Eaux' },
  },
  {
    id: 'fb-021',
    sector_id: 'telecom',
    rating_normalized: 80,
    comment: 'Bon réseau 4G, couverture satisfaisante.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-16T14:20:00Z',
    establishment: { name: 'Telma' },
  },
  {
    id: 'fb-022',
    sector_id: 'education',
    rating_normalized: 45,
    comment: 'Manque de livres et de matériel informatique.',
    status: 'pending',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-15T10:45:00Z',
    establishment: { name: 'Lycée Andohalo' },
  },
  {
    id: 'fb-023',
    sector_id: 'health',
    rating_normalized: 50,
    comment: 'Service de maternité à améliorer.',
    status: 'pending',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-14T08:00:00Z',
    establishment: { name: 'CHU Joseph Ravoahangy' },
  },
  {
    id: 'fb-024',
    sector_id: 'transport',
    rating_normalized: 75,
    comment: 'Routes en bon état, signalisation claire.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-13T16:30:00Z',
    establishment: { name: 'Gare routière de Mahamasina' },
  },
  {
    id: 'fb-025',
    sector_id: 'administration',
    rating_normalized: 30,
    comment: 'Corruption et favoritisme dans les services publics.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-12T09:15:00Z',
    establishment: { name: 'Mairie d\'Antananarivo' },
  },
  {
    id: 'fb-026',
    sector_id: 'commerce',
    rating_normalized: 85,
    comment: 'Très bon marché, produits frais et variés.',
    status: 'validated',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-11T07:30:00Z',
    establishment: { name: 'Marché d\'Andravoahangy' },
  },
  {
    id: 'fb-027',
    sector_id: 'energy',
    rating_normalized: 20,
    comment: 'Factures excessives par rapport à la consommation réelle.',
    status: 'new',
    priority: 1,
    is_critical: true,
    created_at: '2024-05-10T13:00:00Z',
    establishment: { name: 'Jirama' },
  },
  {
    id: 'fb-028',
    sector_id: 'water',
    rating_normalized: 65,
    comment: 'Service d\'eau correct, quelques coupures.',
    status: 'resolved',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-09T11:45:00Z',
    establishment: { name: 'Service des Eaux' },
  },
  {
    id: 'fb-029',
    sector_id: 'telecom',
    rating_normalized: 35,
    comment: 'Service client difficile à joindre, réclamations non traitées.',
    status: 'new',
    priority: 1,
    is_critical: false,
    created_at: '2024-05-08T15:00:00Z',
    establishment: { name: 'Telma' },
  },
  {
    id: 'fb-030',
    sector_id: 'education',
    rating_normalized: 55,
    comment: 'École correcte, mais infrastructure vieillissante.',
    status: 'pending',
    priority: 0,
    is_critical: false,
    created_at: '2024-05-07T09:30:00Z',
    establishment: { name: 'Lycée Andohalo' },
  },
];

// =============================================================================
// COMPOSANT PRINCIPAL
// =============================================================================

/** Liste et modération des feedbacks */
export default function FeedbacksPage() {
  const [feedbacks, setFeedbacks] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [source, setSource] = useState<'supabase' | 'static'>('static');
  const [filterStatus, setFilterStatus] = useState<string>('all');
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    async function fetchFeedbacks() {
      try {
        const supabase = createClient();
        
        // Essayer de récupérer depuis Supabase
        const { data, error: fetchError } = await supabase
          .from('feedbacks')
          .select('*, establishment:establishment_id(name)')
          .order('created_at', { ascending: false })
          .limit(100);

        if (!fetchError && data && data.length > 0) {
          setFeedbacks(data);
          setSource('supabase');
          console.log('✅ Feedbacks chargés depuis Supabase:', data.length);
        } else {
          // Utiliser les données statiques
          setFeedbacks(STATIC_FEEDBACKS);
          setSource('static');
          console.log('📁 Feedbacks statiques chargés:', STATIC_FEEDBACKS.length);
          if (fetchError) {
            console.log('Erreur Supabase:', fetchError.message);
          }
        }
      } catch (err) {
        console.error('Erreur:', err);
        setFeedbacks(STATIC_FEEDBACKS);
        setSource('static');
        setError(err instanceof Error ? err.message : null);
      } finally {
        setLoading(false);
      }
    }

    fetchFeedbacks();
  }, []);

  // Filtres
  const filteredFeedbacks = feedbacks.filter(f => {
    // Filtre par statut
    if (filterStatus !== 'all' && f.status !== filterStatus) return false;
    
    // Filtre par recherche
    if (searchTerm) {
      const search = searchTerm.toLowerCase();
      return (
        f.comment?.toLowerCase().includes(search) ||
        f.sector_id?.toLowerCase().includes(search) ||
        f.establishment?.name?.toLowerCase().includes(search)
      );
    }
    
    return true;
  });

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

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

  const statusColors: Record<string, string> = {
    new: 'bg-blue-100 text-blue-700',
    pending: 'bg-yellow-100 text-yellow-700',
    validated: 'bg-green-100 text-green-700',
    resolved: 'bg-green-100 text-green-700',
    hidden: 'bg-gray-100 text-gray-700',
  };

  const statusLabels: Record<string, string> = {
    new: 'Nouveau',
    pending: 'En attente',
    validated: 'Validé',
    resolved: 'Résolu',
    hidden: 'Masqué',
  };

  const formatDate = (date: string) => {
    try {
      return new Date(date).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
      });
    } catch {
      return date;
    }
  };

  // Statistiques
  const stats = {
    total: filteredFeedbacks.length,
    new: filteredFeedbacks.filter(f => f.status === 'new').length,
    pending: filteredFeedbacks.filter(f => f.status === 'pending').length,
    resolved: filteredFeedbacks.filter(f => f.status === 'resolved' || f.status === 'validated').length,
    critical: filteredFeedbacks.filter(f => f.is_critical || f.priority === 1).length,
  };

  return (
    <div className="space-y-4">
      {/* En-tête */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <h2 className="text-2xl font-bold">Feedbacks</h2>
        <div className="flex items-center gap-2 text-xs">
          <span className={`px-2 py-1 rounded ${source === 'supabase' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
            {source === 'supabase' ? '📡 Supabase' : '📁 Données statiques'}
          </span>
          <span className="text-gray-400">{feedbacks.length} feedbacks</span>
        </div>
      </div>

      {/* Barre de recherche et filtres */}
      <div className="flex flex-col md:flex-row gap-3">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" size={18} />
          <input
            type="text"
            placeholder="Rechercher..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-10 pr-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          {searchTerm && (
            <button
              onClick={() => setSearchTerm('')}
              className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
            >
              <X size={16} />
            </button>
          )}
        </div>
        <div className="flex gap-2 overflow-x-auto">
          <button
            onClick={() => setFilterStatus('all')}
            className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${filterStatus === 'all' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
          >
            Tous ({stats.total})
          </button>
          <button
            onClick={() => setFilterStatus('new')}
            className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${filterStatus === 'new' ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
          >
            Nouveaux ({stats.new})
          </button>
          <button
            onClick={() => setFilterStatus('pending')}
            className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${filterStatus === 'pending' ? 'bg-yellow-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
          >
            En attente ({stats.pending})
          </button>
          <button
            onClick={() => setFilterStatus('resolved')}
            className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${filterStatus === 'resolved' ? 'bg-green-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
          >
            Résolus ({stats.resolved})
          </button>
          <button
            onClick={() => setFilterStatus('critical')}
            className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${filterStatus === 'critical' ? 'bg-red-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
          >
            ⚠️ Critiques ({stats.critical})
          </button>
        </div>
      </div>

      {/* Statistiques rapides */}
      <div className="grid grid-cols-3 md:grid-cols-5 gap-3">
        <div className="bg-white rounded-xl border p-3 text-center">
          <div className="text-xl font-bold text-blue-600">{stats.total}</div>
          <div className="text-xs text-gray-500">Total</div>
        </div>
        <div className="bg-white rounded-xl border p-3 text-center">
          <div className="text-xl font-bold text-blue-600">{stats.new}</div>
          <div className="text-xs text-gray-500">Nouveaux</div>
        </div>
        <div className="bg-white rounded-xl border p-3 text-center">
          <div className="text-xl font-bold text-yellow-600">{stats.pending}</div>
          <div className="text-xs text-gray-500">En attente</div>
        </div>
        <div className="bg-white rounded-xl border p-3 text-center">
          <div className="text-xl font-bold text-green-600">{stats.resolved}</div>
          <div className="text-xs text-gray-500">Résolus</div>
        </div>
        <div className="bg-white rounded-xl border p-3 text-center">
          <div className="text-xl font-bold text-red-600">{stats.critical}</div>
          <div className="text-xs text-gray-500">Critiques</div>
        </div>
      </div>

      {/* Tableau */}
      <div className="bg-white rounded-2xl border overflow-hidden">
        {filteredFeedbacks.length === 0 ? (
          <div className="p-8 text-center text-gray-400">
            <MessageSquare size={40} className="mx-auto mb-2 opacity-50" />
            <p>Aucun feedback trouvé</p>
            {searchTerm && (
              <button
                onClick={() => setSearchTerm('')}
                className="mt-2 text-blue-600 hover:underline"
              >
                Effacer la recherche
              </button>
            )}
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-left text-gray-500">
                <tr>
                  <th className="p-3">Établissement</th>
                  <th className="p-3">Secteur</th>
                  <th className="p-3">Note</th>
                  <th className="p-3">Commentaire</th>
                  <th className="p-3">Statut</th>
                  <th className="p-3">Prio.</th>
                  <th className="p-3">Date</th>
                </tr>
              </thead>
              <tbody>
                {filteredFeedbacks.map((f) => {
                  const sectorLabel = sectorLabels[f.sector_id] || f.sector_id;
                  const statusColor = statusColors[f.status] || 'bg-gray-100 text-gray-700';
                  const statusLabel = statusLabels[f.status] || f.status;
                  const rating = ((f.rating_normalized ?? 0) / 20).toFixed(1);
                  const establishmentName = f.establishment?.name || f.establishment_name || '—';

                  return (
                    <tr key={f.id} className="border-t hover:bg-gray-50 transition-colors">
                      <td className="p-3 text-sm">
                        {establishmentName}
                      </td>
                      <td className="p-3">
                        <span className="text-xs font-medium px-2 py-0.5 rounded bg-blue-100 text-blue-700">
                          {sectorLabel}
                        </span>
                      </td>
                      <td className="p-3">
                        <span className={`font-medium ${parseFloat(rating) < 2 ? 'text-red-600' : parseFloat(rating) < 3 ? 'text-yellow-600' : 'text-green-600'}`}>
                          {rating}/5
                        </span>
                      </td>
                      <td className="p-3 max-w-xs truncate" title={f.comment || ''}>
                        {f.comment || '—'}
                      </td>
                      <td className="p-3">
                        <span className={`text-xs font-medium px-2 py-0.5 rounded ${statusColor}`}>
                          {statusLabel}
                        </span>
                      </td>
                      <td className="p-3">
                        {f.is_critical || f.priority === 1 ? (
                          <span className="text-red-600">⚠️</span>
                        ) : (
                          <span className="text-gray-300">—</span>
                        )}
                      </td>
                      <td className="p-3 text-xs text-gray-400">
                        {formatDate(f.created_at)}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}