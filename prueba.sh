numero_secreto=$((RANDOM % 100 + 1))
nose=0
contador=10

while [ $contador -ge 0 ] 
do
echo -e "\n $contador"
    sleep 1
    contador=$((contador-1))
done & 

adivinado=0

while [ $adivinado -eq 0 ]; do
    read -p "Ingresa tu suposición: " suposicion        

        if [ $contador -eq 0 ]; then
            echo -e "\nSe acabo el tiempo $contador"
            adivinado=1
        fi

        if [ $suposicion -eq $numero_secreto ]; then
            echo "¡Felicidades! Adivinaste el número secreto ($numero_secreto)."
            cant_adivinado=$(( $cant_adivinado + 1))
            adivinado=1
            if [ $adivinado -eq 1 ]; then
                numero_secreto=$((RANDOM % 100 + 1))
            fi
            echo -e "\nListo para la siguiente ronda?"
            adivinado=0
        elif [ $suposicion -lt $numero_secreto ]; then
            echo "El número secreto es mayor que $suposicion. Sigue intentando."
        else
            echo "El número secreto es menor que $suposicion. Sigue intentando."
        fi
done