import { redirect } from 'next/navigation';

/** Racine : redirige vers le tableau de bord (le middleware gère l'auth). */
export default function Home() {
  redirect('/dashboard');
}
