
import type { ColumnDef } from "@tanstack/react-table"
import { ArrowUpDown } from "lucide-react"
import { Button } from "@/components/ui/button"

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"

export type RegistrationStatus =
  | "Pendente"
  | "Confirmada"
  | "Cancelada"

export type Registration = {
  id: number
  name: string
  group: string
  section: string
  constellation: string
  status: RegistrationStatus
}

export function getRegistrationColumns(
  onStatusChange: (id: number, status: RegistrationStatus) => void
): ColumnDef<Registration>[] {

  return [
    {
      accessorKey: "id",
      header: ({ column }) => (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(
            column.getIsSorted() === "asc"
          )}
        >
          ID
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      ),
    },
    {
      accessorKey: "name",
      header: ({ column }) => (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(
            column.getIsSorted() === "asc"
          )}
        >
          Nome
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      ),
    },
    {
      accessorKey: "group",
      header: ({ column }) => (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(
            column.getIsSorted() === "asc"
          )}
        >
          Agrupamento
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      ),
    },
    {
      accessorKey: "section",
      header: "Secção",
    },
    {
      accessorKey: "constellation",
      header: "Constelação",
    },
    {
      accessorKey: "status",
      header: "Estado",
      cell: ({ row }) => {
        const registration = row.original
        const status = registration.status

        return (
          <Select
            value={status}
            onValueChange={(value) =>
              onStatusChange(
                registration.id,
                value as RegistrationStatus
              )
            }
          >
            <SelectTrigger className="w-[145px]">
              <SelectValue />
            </SelectTrigger>

            <SelectContent>
              <SelectItem value="Pendente">
                Pendente
              </SelectItem>
              <SelectItem value="Confirmada">
                Confirmada
              </SelectItem>
              <SelectItem value="Cancelada">
                Cancelada
              </SelectItem>
            </SelectContent>
          </Select>
        )
      },
    },
  ]
}
