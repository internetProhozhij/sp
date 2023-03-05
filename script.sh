#!bin/bash

info () {
    echo "Автор: cтудент гр. 729-1 Шандаков А. П."
    echo "Описание: скрипт для изменения пароля пользователя"
    echo
}

is_number () {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        return 0
    fi
    
    echo "Количество дней должно быть целым, положительным числм."
    return 1
}

main () {
    info 
    read -p "Имя пользователя: " targetUser
    
    while true; do
        does_exist=$(grep -c $targetUser /etc/passwd)
        if [ $does_exist -gt 0 ]; then
            while true; do
                read -p "Минимальное время жизни пароля (в днях): " minDays
                if ! is_number $minDays; then
                    read -p "Попробовать еще раз? (y/n): " userDecision
                    if [ ! "$userDecision" = "y" ] || [ ! "$userDecision" = "Y"]; then
                        echo "Выход (изменения не применены) ..."
                        return 1
                    fi
                fi
                break
            done

            while true; do
                read -p "Максимальное время жизни пароля (в днях): " maxDays
                if ! is_number $maxDays; then
                    read -p "Попробовать еще раз? (y/n): " userDecision
                    if [ ! "$userDecision" = "y" ] || [ ! "$userDecision" = "Y"]; then
                        echo "Выход (изменения не применены) ..."
                        return 1
                    fi
                fi
                break
            done
            
            passwd $targetUser
            passwd -n $minDays -x $maxDays $targetUser 
            read -p "Продолжить? (y/n)" userDecision
            if [ ! "$userDecision" = "y" ] || [ ! "$userDecision" = "Y"]; then
                echo "Выход ..."
                return 1
            fi
        else
            read -p "Пользователь $targetUser не существует. Попробовать еще раз? (y/n): " userDecision
            if [ ! "$userDecision" = "y" ] || [ ! "$userDecision" = "Y"]; then
                echo "Выход (изменения не применены) ..."
                return 1
            fi
        fi
    done
}

main
