import { RegistrationsTable } from "@/components/admin/table/RegistrationsTable"

export default function InscricoesPage() {
  return (
    <div className="p-8 space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">
          Inscrições
        </h1>
        <p className="text-muted-foreground">
          Gere e acompanha as inscrições.
        </p>
      </div>

      {/* Tabela de inscrições */}
      <RegistrationsTable />

    </div>
  )
}