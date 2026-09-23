ALTER TABLE jogador
    ADD CONSTRAINT uq_jogador_time_numero
    UNIQUE (id_time, numero_camisa);


ALTER TABLE jogador
    ADD CONSTRAINT ck_jogador_numero_camisa
    CHECK (numero_camisa BETWEEN 1 AND 99);


ALTER TABLE time_futebol
    ADD CONSTRAINT uq_time_nome
    UNIQUE (nome);