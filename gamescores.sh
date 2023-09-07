#!/bin/bash
password=120523
PSQL="psql -d gamescore -U postgres -c"

MAIN_MENU(){
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi
    echo -e "\nBienvenido al juego de las adivinanzas :P"

    VER_USER=0;
    while [ $VER_USER -eq 0 ]; do
    # Un bucle para validar que hay un usuario registrado jugando
        echo -e "\nEres nuevo en el juego? (Y/N)"
        read QNEW # Question New in the game? 
        if [ $QNEW = "Y" ]; then
            echo -e "\nCual es tu nombre?"
            read NEWNAME
            echo -e "\nCual es tu alias?"
            read NEWALIAS
            CREATE_PLAYER=$($PSQL "INSERT INTO jugadores(nombre, alias) VALUES ('$NEWNAME', '$NEWALIAS');" )
            echo -e "\nListo! Has sido agregado."
            VER_USER=1
        else
            echo -e "\nCual es tu alias?"
            read ALIAS
            VER_ALIAS=$($PSQL "SELECT COUNT(*) FROM jugadores WHERE alias = '$ALIAS';" "-t")
            if [ "$VER_ALIAS" -gt 0 ]; then
                echo -e "\nPerfecto puedes seguir."
                VER_USER=1
            else
                echo "Lo siento, el alias que ingresaste no esta registrado"
            fi
        fi
    done
    
    echo -e "\nSelecciona el modo de juego:"
    echo -e "\n1) Infinito\n2) Contrareloj\n3) Salir"
    read MODO_DE_JUEGO

    case $MODO_DE_JUEGO in
        1) MODE_INFINITO ;;
        2) EXIT ;;
        *) MAIN_MENU "Ingresa una opción válida" ;;
    esac
}

MODE_INFINITO(){
  # Una funcion del modo de juego (infinito)
  echo -e "\nEscogiste el modo de juego infinito"
  echo -e "\nLas reglas son simples: tienes 10 intentos para poder adivinar el numero, si logras"
  echo -e "adivinar el numero pasas al siguiente round y vuelves a tener 10 intentos y así"
  echo -e "Sucesivamente."

    numero_secreto=$((RANDOM % 100 + 1))

    echo "¡Bienvenido al juego de adivinar el número!"
    echo "Intenta adivinar el número secreto entre 1 y 100."

    intentos=0
    adivinado=0

    while [ $adivinado -eq 0 ]; do
        read -p "Ingresa tu suposición: " suposicion
        ((intentos++))
        

        if [ $intentos -lt 10 ]; then
            if [ $suposicion -eq $numero_secreto ]; then
                echo "¡Felicidades! Adivinaste el número secreto ($numero_secreto) en $intentos intentos."
                adivinado=1
                if [ $adivinado -eq 1 ]; then
                    numero_secreto=$((RANDOM % 100 + 1))
                fi
                echo -e "\nListo para la siguiente ronda?"
                puntuacion=$(($puntuacion + (10 - $intentos) * 10))
                adivinado=0
                intentos=0
            elif [ $suposicion -lt $numero_secreto ]; then
                echo "El número secreto es mayor que $suposicion. Sigue intentando."
            else
                echo "El número secreto es menor que $suposicion. Sigue intentando."
            fi
        else
            echo -e "\nHas perdido :/"
            break
        fi
    done

    echo -e "\nTu puntuacion ha sido de $puntuacion"
    if [ $ALIAS = '' ]; then
        $ALIAS=$NEWALIAS
    fi
    PLAYER_ID=$($PSQL "SELECT jugador_id FROM jugadores WHERE alias = '$ALIAS';" "-t")
    ADD_SCORE=$($PSQL "INSERT INTO puntajes(puntaje_id, modo_de_juego, jugador) VALUES ( $puntuacion, 1, $PLAYER_ID);")
   
}

EXIT(){
    echo -e "\nGracias por finalizar el script."
}

MAIN_MENU