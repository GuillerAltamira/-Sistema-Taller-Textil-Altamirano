CREAR BASE DE DATOS 
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TallerTextilDB')
CREATE DATABASE TallerTextilDB;
GO
USE TallerTextilDB;
GO

//CLIENTES
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Clientes]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[Clientes](
        [IdCliente] INT PRIMARY KEY IDENTITY(1,1),
        [Nombre] NVARCHAR(100) NOT NULL,
        [Telefono] NVARCHAR(20)
    )
END
GO

//PEDIDOS 
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Pedidos]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[Pedidos](
        [IdPedido] INT PRIMARY KEY IDENTITY(1,1),
        [IdCliente] INT NOT NULL,
        [TipoPrenda] NVARCHAR(100),
        [Cantidad] INT,
        [FechaRegistro] DATE,
        [FechaEntrega] DATE,
        [Estado] NVARCHAR(50),
        FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
    )
END
GO

//COSTURERAS
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Costureras]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[Costureras](
        [IdCosturera] INT PRIMARY KEY IDENTITY(1,1),
        [Nombre] NVARCHAR(100),
        [Telefono] NVARCHAR(20)
    )
END
GO

//PRODUCCIONES
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Producciones]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[Producciones](
        [IdProduccion] INT PRIMARY KEY IDENTITY(1,1),
        [IdPedido] INT NOT NULL,
        [IdCosturera] INT NOT NULL,
        [CantidadTerminada] INT,
        [FechaFin] DATE,
        FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido),
        FOREIGN KEY (IdCosturera) REFERENCES Costureras(IdCosturera)
    )
END
GO

//TELAS 
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Telas]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[Telas](
        [IdTela] INT PRIMARY KEY IDENTITY(1,1),
        [Tipo] NVARCHAR(100),
        [Color] NVARCHAR(50),
        [MetrosStock] DECIMAL(10,2),
        [FechaIngreso] DATE
    )
END
GO

//PEDIDO-TELA 
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[PedidoTela]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[PedidoTela](
        [IdPedidoTela] INT PRIMARY KEY IDENTITY(1,1),
        [IdPedido] INT NOT NULL,
        [IdTela] INT NOT NULL,
        [MetrosUsados] DECIMAL(10,2),
        [FechaUso] DATE,
        FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido),
        FOREIGN KEY (IdTela) REFERENCES Telas(IdTela)
    )
END
GO
//MOVIMIENTOS FINANCIEROS
IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[MovimientosFinancieros]') 
    AND type in (N'U')
)
BEGIN
    CREATE TABLE [dbo].[MovimientosFinancieros](
        [IdMovimiento] INT PRIMARY KEY IDENTITY(1,1),
        [IdPedido] INT NOT NULL,
        [Tipo] NVARCHAR(20), -- Ingreso/Gasto
        [Monto] DECIMAL(10,2),
        [Fecha] DATE,
        [Descripcion] NVARCHAR(200),
        FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
    )
END
GO
