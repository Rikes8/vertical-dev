"use client"

import * as React from "react"
import Link from "next/link"
import { usePathname } from "next/navigation"

import {
  LayoutDashboard,
  Users,
  ShoppingBag,
  Package,
  Settings,
  Telescope,
  ExternalLink,
} from "lucide-react"

import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarRail,
} from "@/components/ui/sidebar"

const navMain = [
  {
    title: "Dashboard",
    url: "/admin",
    icon: LayoutDashboard,
  },
]

const navManagement = [
  {
    title: "Inscrições",
    url: "/admin/inscricoes",
    icon: Users,
  },
  {
    title: "Encomendas",
    url: "/admin/encomendas",
    icon: ShoppingBag,
  },
  {
    title: "Produtos",
    url: "/admin/produtos",
    icon: Package,
  },
]

const navSettings = [
  {
    title: "Definições",
    url: "/admin/definicoes",
    icon: Settings,
  },
]

export function AppSidebar(
  props: React.ComponentProps<typeof Sidebar>
) {
  const pathname = usePathname()

  const isActive = (url: string) => {
    if (url === "/admin") return pathname === url
    return pathname === url || pathname.startsWith(`${url}/`)
  }

  const renderMenu = (
    items: typeof navMain
  ) => (
    <SidebarMenu>
      {items.map((item) => (
        <SidebarMenuItem key={item.title}>
          <SidebarMenuButton
            render={<Link href={item.url} />}
            isActive={isActive(item.url)}
            tooltip={item.title}
          >
            <item.icon />
            <span>{item.title}</span>
          </SidebarMenuButton>
        </SidebarMenuItem>
      ))}
    </SidebarMenu>
  )

  return (
    <Sidebar collapsible="icon" {...props}>
      <SidebarHeader>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton
              size="lg"
              render={<Link href="/admin" />}
            >
              <div className="flex aspect-square size-8 items-center justify-center rounded-lg bg-sidebar-primary text-sidebar-primary-foreground">
                <Telescope className="size-4" />
              </div>

              <div className="grid flex-1 text-left text-sm leading-tight">
                <span className="truncate font-bold tracking-wide">
                  VERTICAL
                </span>
                <span className="truncate text-xs text-muted-foreground">
                  Administração
                </span>
              </div>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarHeader>

      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>
            Plataforma
          </SidebarGroupLabel>
          <SidebarGroupContent>
            {renderMenu(navMain)}
          </SidebarGroupContent>
        </SidebarGroup>

        <SidebarGroup>
          <SidebarGroupLabel>
            Gestão
          </SidebarGroupLabel>
          <SidebarGroupContent>
            {renderMenu(navManagement)}
          </SidebarGroupContent>
        </SidebarGroup>

        <SidebarGroup>
          <SidebarGroupLabel>
            Sistema
          </SidebarGroupLabel>
          <SidebarGroupContent>
            {renderMenu(navSettings)}
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>

      <SidebarFooter>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton
              render={<Link href="/" />}
              tooltip="Voltar ao site"
            >
              <ExternalLink />
              <span>Voltar ao site</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>

      <SidebarRail />
    </Sidebar>
  )
}
