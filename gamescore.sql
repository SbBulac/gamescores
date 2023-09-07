CREATE DATABASE gamescore;

CREATE TABLE jugadores();
ALTER TABLE jugadores ADD COLUMN jugador_id SERIAL NOT NULL PRIMARY KEY;
ALTER TABLE jugadores ADD COLUMN nombre VARCHAR(50) NOT NULL;
ALTER TABLE jugadores ADD COLUMN alias VARCHAR(20) NOT NULL;

CREATE TABLE modos_de_juego();
ALTER TABLE modos_de_juego ADD COLUMN modo_de_juego_id SERIAL NOT NULL PRIMARY KEY;
ALTER TABLE modos_de_juego ADD COLUMN nombre VARCHAR(50) NOT NULL;

CREATE TABLE puntajes();
ALTER TABLE puntajes ADD COLUMN puntaje_id SERIAL NOT NULL PRIMARY KEY;
ALTER TABLE puntajes ADD COLUMN modo_de_juego INT NOT NULL;
ALTER TABLE puntajes ADD COLUMN jugador INT NOT NULL;

ALTER TABLE puntajes
ADD CONSTRAINT fk_modo_de_juego
FOREIGN KEY (modo_de_juego) REFERENCES modos_de_juego(modo_de_juego_id);

ALTER TABLE puntajes
ADD CONSTRAINT fk_jugador
FOREIGN KEY (jugador) REFERENCES jugadores(jugador_id);


