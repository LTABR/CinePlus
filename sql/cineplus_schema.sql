DROP SCHEMA db_cineplus;
CREATE SCHEMA db_cineplus;
USE
db_cineplus;

CREATE TABLE `cliente`
(
    `idCliente` int(11) NOT NULL AUTO_INCREMENT,
    `nome`      varchar(70) NOT NULL,
    `email`     varchar(70) NOT NULL,
    `telefone`  varchar(20) NOT NULL,
    PRIMARY KEY (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `filme`
(
    `idFilme` int(11) NOT NULL AUTO_INCREMENT,
    `titulo`  varchar(70) NOT NULL,
    `genero`  varchar(30) NOT NULL,
    `duracao` int(11) NOT NULL DEFAULT 1,
    PRIMARY KEY (`idFilme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ingresso`
(
    `idIngresso`  int(11) NOT NULL AUTO_INCREMENT,
    `idCliente`   int(11) NOT NULL,
    `idSessao`    int(11) NOT NULL,
    `idPagamento` int(11) NOT NULL,
    PRIMARY KEY (`idIngresso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pagamento`
(
    `idPagamento`    int(11) NOT NULL AUTO_INCREMENT,
    `parcelas`       int(2) NOT NULL DEFAULT 1,
    `valorParcela`   decimal(10, 2) NOT NULL DEFAULT 0,
    `formaPagamento` varchar(20)    NOT NULL,
    `meiaEntrada`    bool           NOT NULL DEFAULT false,
    PRIMARY KEY (`idPagamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `sala`
(
    `idSala`     int(11) NOT NULL AUTO_INCREMENT,
    `capacidade` int(11) NOT NULL DEFAULT 1,
    PRIMARY KEY (`idSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `sessao`
(
    `idSessao` int(11) NOT NULL AUTO_INCREMENT,
    `datahora` datetime NOT NULL DEFAULT current_timestamp(),
    `idFilme`  int(11) NOT NULL,
    PRIMARY KEY (`idSessao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `sessoessala`
(
    `idSala`   int(11) NOT NULL,
    `idSessao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



DELIMITER
//
CREATE TRIGGER `tg_deletar_sessoes_expiradas`
    BEFORE INSERT
    ON `ingresso`
    FOR EACH ROW
BEGIN
    DELETE s FROM `sessao` s
    INNER JOIN `filme` f ON s.idFilme = f.idFilme
    WHERE DATE_ADD(s.datahora, INTERVAL f.duracao MINUTE) < CURRENT_TIMESTAMP();
END // DELIMITER;


-- Movies
INSERT INTO `filme` (`titulo`, `genero`, `duracao`)
VALUES ('Interstellar', 'Sci-Fi', 169),
       ('The Godfather', 'Crime', 175),
       ('Spirited Away', 'Animação', 125);

-- Rooms (Sala)
INSERT INTO `sala` (`capacidade`)
VALUES (150),
       (80),
       (200);

-- Payment Methods
INSERT INTO `pagamento` (`parcelas`, `valorParcela`, `formaPagamento`, `meiaEntrada`)
VALUES (1, 45.00, 'Cartão', true),
       (3, 20.00, 'Cartão', false),
       (1, 45.00, 'Boleto', true),
       (2, 25.00, 'Pix', false);



-- Sessions (Linking to Filme)
-- Note: idFilme is UNIQUE in your schema, so 1 movie = 1 session only.
INSERT INTO `sessao` (`datahora`, `idFilme`)
VALUES ('2030-04-30 14:00:00', 1),
       ('2030-04-30 17:30:00', 2),
       ('2030-04-30 20:00:00', 3),
       ('2030-04-30 17:30:00', 1);

-- Clients
INSERT INTO `cliente` (`nome`, `email`, `telefone`)
VALUES ('Alice Freeman', 'alice@email.com', '11 98888-7777'),
       ('Bruno Silva', 'bruno@email.com', '11 97777-6666'),
       ('Carla Souza', 'carla@email.com', '11 96666-5555');


-- Assigning Sessions to Rooms (SessoesSala)
INSERT INTO `sessoessala` (`idSala`, `idSessao`)
VALUES (1, 1), -- Session 1 in Room 1
       (2, 2), -- Session 2 in Room 2
       (3, 3), -- Session 3 in Room 3
       (2, 1);
-- Session 1 in Room 2

-- Generating Tickets (Ingresso)
-- Links: Client <-> Session <-> Payment
INSERT INTO `ingresso` (`idCliente`, `idSessao`, `idPagamento`)
VALUES (1, 1, 1), -- Alice watching Interstellar
       (2, 2, 2), -- Bruno watching The Godfather
       (3, 3, 3), -- Carla watching Spirited Away
       (1, 3, 4); -- Alice watching Spirited Away


ALTER TABLE SessoesSala
    ADD CONSTRAINT fk_sessoessala_sala FOREIGN KEY (idSala) REFERENCES Sala (idSala) ON DELETE CASCADE,
 ADD CONSTRAINT fk_sessoessala_sessao FOREIGN KEY (idSessao) REFERENCES Sessao(idSessao) ON
DELETE
CASCADE;

ALTER TABLE Ingresso
    ADD CONSTRAINT fk_ingresso_sessao FOREIGN KEY (idSessao) REFERENCES Sessao (idSessao) ON DELETE CASCADE,
    ADD CONSTRAINT fk_ingresso_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON
DELETE
CASCADE,
    ADD CONSTRAINT fk_ingresso_pagamento FOREIGN KEY (idPagamento) REFERENCES Pagamento(idPagamento) ON DELETE
CASCADE;

ALTER TABLE Sessao
    ADD CONSTRAINT fk_sessao_filme FOREIGN KEY (idFilme) REFERENCES Filme (idFilme) ON DELETE CASCADE;