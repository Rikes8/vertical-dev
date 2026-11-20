-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "Seccao" AS ENUM ('EXPLORADORES', 'PIONEIROS', 'CAMINHEIROS');

-- CreateEnum
CREATE TYPE "InscricaoStatus" AS ENUM ('PENDENTE', 'CONFIRMADA', 'CANCELADA');

-- CreateEnum
CREATE TYPE "EncomendaStatus" AS ENUM ('PENDENTE', 'PAGA', 'ENVIADA', 'ENTREGUE', 'CANCELADA');

-- CreateEnum
CREATE TYPE "EncomendaItemTipo" AS ENUM ('PRODUTO', 'PACK');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,
    "passwordHash" TEXT,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "agrupamentoId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verification_tokens" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "agrupamentos" (
    "id" TEXT NOT NULL,
    "numero" TEXT NOT NULL,
    "nome" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agrupamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "constelacoes" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "responsavelNome" TEXT NOT NULL,
    "responsavelEmail" TEXT NOT NULL,
    "responsavelTelefone" TEXT NOT NULL,
    "guiaEmail" TEXT NOT NULL,
    "guiaTelefone" TEXT NOT NULL,
    "status" "InscricaoStatus" NOT NULL DEFAULT 'PENDENTE',
    "agrupamentoId" TEXT NOT NULL,
    "criadoPorId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "constelacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "elementos" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "seccao" "Seccao" NOT NULL,
    "dataNascimento" DATE NOT NULL,
    "isGuia" BOOLEAN NOT NULL DEFAULT false,
    "constelacaoId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "elementos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nomes_pool" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "constelacaoId" TEXT,

    CONSTRAINT "nomes_pool_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "configuracao_inscricao" (
    "id" TEXT NOT NULL DEFAULT 'singleton',
    "preInscricoesInicio" TIMESTAMP(3),
    "preInscricoesFim" TIMESTAMP(3),
    "inscricoesInicio" TIMESTAMP(3),
    "inscricoesFim" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "configuracao_inscricao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produtos" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "descricao" TEXT,
    "precoCents" INTEGER NOT NULL,
    "edicao" INTEGER NOT NULL,
    "imagens" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "produtos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "variantes_produto" (
    "id" SERIAL NOT NULL,
    "tamanho" TEXT NOT NULL DEFAULT 'UNICO',
    "stock" INTEGER NOT NULL DEFAULT 0,
    "produtoId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "variantes_produto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "packs" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "descricao" TEXT,
    "precoCents" INTEGER NOT NULL,
    "edicao" INTEGER NOT NULL,
    "imagemUrl" TEXT,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "packs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pack_itens" (
    "id" SERIAL NOT NULL,
    "quantidade" INTEGER NOT NULL DEFAULT 1,
    "packId" INTEGER NOT NULL,
    "produtoId" INTEGER NOT NULL,

    CONSTRAINT "pack_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "encomendas" (
    "id" TEXT NOT NULL,
    "numero" SERIAL NOT NULL,
    "clienteNome" TEXT NOT NULL,
    "clienteEmail" TEXT NOT NULL,
    "clienteTelefone" TEXT NOT NULL,
    "moradaLinha" TEXT NOT NULL,
    "codigoPostal" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "status" "EncomendaStatus" NOT NULL DEFAULT 'PENDENTE',
    "totalCents" INTEGER NOT NULL,
    "userId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "encomendas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "encomenda_itens" (
    "id" SERIAL NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "precoUnitCents" INTEGER NOT NULL,
    "nomeProduto" TEXT NOT NULL,
    "tamanho" TEXT,
    "tipo" "EncomendaItemTipo" NOT NULL,
    "varianteId" INTEGER,
    "encomendaId" TEXT NOT NULL,
    "produtoId" INTEGER,
    "packId" INTEGER,

    CONSTRAINT "encomenda_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "encomenda_item_componentes" (
    "id" SERIAL NOT NULL,
    "nomeProduto" TEXT NOT NULL,
    "tamanho" TEXT,
    "quantidade" INTEGER NOT NULL DEFAULT 1,
    "itemId" INTEGER NOT NULL,
    "produtoId" INTEGER,

    CONSTRAINT "encomenda_item_componentes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_agrupamentoId_idx" ON "users"("agrupamentoId");

-- CreateIndex
CREATE INDEX "users_role_idx" ON "users"("role");

-- CreateIndex
CREATE INDEX "accounts_userId_idx" ON "accounts"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_provider_providerAccountId_key" ON "accounts"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_sessionToken_key" ON "sessions"("sessionToken");

-- CreateIndex
CREATE INDEX "sessions_userId_idx" ON "sessions"("userId");

-- CreateIndex
CREATE INDEX "sessions_expires_idx" ON "sessions"("expires");

-- CreateIndex
CREATE UNIQUE INDEX "verification_tokens_token_key" ON "verification_tokens"("token");

-- CreateIndex
CREATE UNIQUE INDEX "verification_tokens_identifier_token_key" ON "verification_tokens"("identifier", "token");

-- CreateIndex
CREATE UNIQUE INDEX "agrupamentos_numero_key" ON "agrupamentos"("numero");

-- CreateIndex
CREATE INDEX "constelacoes_agrupamentoId_status_idx" ON "constelacoes"("agrupamentoId", "status");

-- CreateIndex
CREATE INDEX "constelacoes_criadoPorId_idx" ON "constelacoes"("criadoPorId");

-- CreateIndex
CREATE INDEX "elementos_constelacaoId_idx" ON "elementos"("constelacaoId");

-- CreateIndex
CREATE UNIQUE INDEX "nomes_pool_nome_key" ON "nomes_pool"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "nomes_pool_constelacaoId_key" ON "nomes_pool"("constelacaoId");

-- CreateIndex
CREATE UNIQUE INDEX "produtos_slug_key" ON "produtos"("slug");

-- CreateIndex
CREATE INDEX "produtos_edicao_ativo_idx" ON "produtos"("edicao", "ativo");

-- CreateIndex
CREATE UNIQUE INDEX "variantes_produto_produtoId_tamanho_key" ON "variantes_produto"("produtoId", "tamanho");

-- CreateIndex
CREATE UNIQUE INDEX "packs_slug_key" ON "packs"("slug");

-- CreateIndex
CREATE INDEX "packs_edicao_ativo_idx" ON "packs"("edicao", "ativo");

-- CreateIndex
CREATE INDEX "pack_itens_produtoId_idx" ON "pack_itens"("produtoId");

-- CreateIndex
CREATE UNIQUE INDEX "pack_itens_packId_produtoId_key" ON "pack_itens"("packId", "produtoId");

-- CreateIndex
CREATE UNIQUE INDEX "encomendas_numero_key" ON "encomendas"("numero");

-- CreateIndex
CREATE INDEX "encomendas_status_createdAt_idx" ON "encomendas"("status", "createdAt");

-- CreateIndex
CREATE INDEX "encomendas_userId_idx" ON "encomendas"("userId");

-- CreateIndex
CREATE INDEX "encomenda_itens_varianteId_idx" ON "encomenda_itens"("varianteId");

-- CreateIndex
CREATE INDEX "encomenda_itens_encomendaId_idx" ON "encomenda_itens"("encomendaId");

-- CreateIndex
CREATE INDEX "encomenda_itens_produtoId_idx" ON "encomenda_itens"("produtoId");

-- CreateIndex
CREATE INDEX "encomenda_itens_packId_idx" ON "encomenda_itens"("packId");

-- CreateIndex
CREATE INDEX "encomenda_item_componentes_itemId_idx" ON "encomenda_item_componentes"("itemId");

-- CreateIndex
CREATE INDEX "encomenda_item_componentes_produtoId_idx" ON "encomenda_item_componentes"("produtoId");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_agrupamentoId_fkey" FOREIGN KEY ("agrupamentoId") REFERENCES "agrupamentos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "constelacoes" ADD CONSTRAINT "constelacoes_agrupamentoId_fkey" FOREIGN KEY ("agrupamentoId") REFERENCES "agrupamentos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "constelacoes" ADD CONSTRAINT "constelacoes_criadoPorId_fkey" FOREIGN KEY ("criadoPorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elementos" ADD CONSTRAINT "elementos_constelacaoId_fkey" FOREIGN KEY ("constelacaoId") REFERENCES "constelacoes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "nomes_pool" ADD CONSTRAINT "nomes_pool_constelacaoId_fkey" FOREIGN KEY ("constelacaoId") REFERENCES "constelacoes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "variantes_produto" ADD CONSTRAINT "variantes_produto_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pack_itens" ADD CONSTRAINT "pack_itens_packId_fkey" FOREIGN KEY ("packId") REFERENCES "packs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pack_itens" ADD CONSTRAINT "pack_itens_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomendas" ADD CONSTRAINT "encomendas_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomenda_itens" ADD CONSTRAINT "encomenda_itens_varianteId_fkey" FOREIGN KEY ("varianteId") REFERENCES "variantes_produto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomenda_itens" ADD CONSTRAINT "encomenda_itens_encomendaId_fkey" FOREIGN KEY ("encomendaId") REFERENCES "encomendas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomenda_itens" ADD CONSTRAINT "encomenda_itens_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomenda_itens" ADD CONSTRAINT "encomenda_itens_packId_fkey" FOREIGN KEY ("packId") REFERENCES "packs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomenda_item_componentes" ADD CONSTRAINT "encomenda_item_componentes_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "encomenda_itens"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "encomenda_item_componentes" ADD CONSTRAINT "encomenda_item_componentes_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "produtos"("id") ON DELETE SET NULL ON UPDATE CASCADE;
