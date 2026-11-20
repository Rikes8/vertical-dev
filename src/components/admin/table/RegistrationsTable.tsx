
"use client"

import { useState } from "react"

import { DataTable } from "./DataTable"
import {
  getRegistrationColumns,
  type Registration,
  type RegistrationStatus,
} from "./columns/RegistrationsColumns"

const initialData: Registration[] = [
  {
    id: 1,
    name: "João Silva",
    group: "Agrupamento 559 - Lama",
    section: "Exploradores",
    constellation: "Lobos",
    status: "Confirmada",
  },
  {
    id: 2,
    name: "Maria Costa",
    group: "Agrupamento 559 - Lama",
    section: "Pioneiros",
    constellation: "Fénix",
    status: "Pendente",
  },
  {
    id: 3,
    name: "Ana Rodrigues",
    group: "Agrupamento 559 - Lama",
    section: "Pioneiros",
    constellation: "Fénix",
    status: "Pendente",
  },
]

export function RegistrationsTable() {
  const [data, setData] = useState(initialData)

  const handleStatusChange = (
    id: number,
    status: RegistrationStatus
  ) => {
    setData((previousData) =>
      previousData.map((registration) =>
        registration.id === id
          ? { ...registration, status }
          : registration
      )
    )
  }

  const columns = getRegistrationColumns(handleStatusChange)

  return (
    <DataTable
      columns={columns}
      data={data}
    />
  )
}
