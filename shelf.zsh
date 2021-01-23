#
#             dP                dP .8888b 
#             88                88 88   " 
#    .d8888b. 88d888b. .d8888b. 88 88aaa  
#    Y8ooooo. 88'  `88 88ooood8 88 88     
#          88 88    88 88.  ... 88 88     
#    `88888P' dP    dP `88888P' dP dP     
# 
# A simple program to bookmark and open 
# random files. All it requires is a xdg-open 
# compatible resource opener.
#
# Author: ecmma <ecmma at anche dot no>
# Year: 2020  
# License: GNU GPLv3
#



#---------------------------------------------
# The main function.
#       To add a command add an entry in $commands_table with the 
#       relative description and add the relative function inside 
#       the body of shelf(). 
#       Be aware that if no completion is specified in _shelf, 
#       obviously no completion for your new command will be available. 
#-----

shelf() {

        
        declare -A commands_table
        
        CONFIG_PATH=$HOME/.config/shelf
        SHELF_MARK_PATH=$CONFIG_PATH/shelf_list.sh
        
        commands_table[open]="<id> Open a previously added bmark"
        commands_table[add]="<id> <file> Add a new bmark with <id> to <file>"   
        commands_table[remove]="<id> Remove a previously added bmark"     
        commands_table[list]="List all bmarks"
         
        
        # Check if the config directory exists
        if [[ -d $CONFIG_PATH ]]; then 
                # ...and if previous marks are set
                if [[ -f $SHELF_MARK_PATH ]]; then 
                        source $SHELF_MARK_PATH
                else 
                        declare -A shelf_list
                fi
        else 
                # The user may want to specify a different 
                # config path. This may be a todo!
                mkdir $CONFIG_PATH
                declare -A shelf_list
        fi       
        
        usage() {
                echo "usage: shelf [command] <?arg(s)>"
                for com msg in "${(@kv)commands_table}"; do
                        printf "\t%s \t%s\n" $com $msg
                done
        }
        
        open() {
        
                if [[ $# < 1 ]]; then 
                        echo "Missing argument."
                        usage 
                        return 1
                fi
        
                if [[ -z $shelf_list[$1] ]]; then 
                        echo "No mark with id '$1'."
                        return 1
                else
                        file=${shelf_list[$1]}
                        if command -v mimeo &> /dev/null; then 
                                mime_info=`mimeo -c $file 2> /dev/null`
                                program=`echo $mime_info | awk '{print $1}'`
                        elif command -v xdg-open &> /dev/null; then
                                program="xdg-open"
                        elif command -v open &> /dev/null; then
                                program="open"
                        else 
                                echo "No suitable xdg-open compatible mime manager."
                        fi
        
                        if [[ -f $file ]]; then 
                                $program $file &!
                        else 
                                echo "$file: no such file or directory."
                                return 1
                        fi
                fi
        }
        
        
        add() {
        
                if [[ $# < 2 ]]; then 
                        echo "Missing argument(s)."
                        usage 
                        return 1
                fi
        
                if [[ ! -z $shelf_list[$1] ]]; then 
                        echo "$1: already exists in list as ${shelf_list[$1]}."
                        return 1
                else
                        if [[ $2 != /* ]]; then 
                                file="$(pwd)/$2"
                        else 
                                file=$2
                        fi
        
                        shelf_list[$1]="$file"
                        typeset -p shelf_list > $SHELF_MARK_PATH
        
                fi
        }
        
        remove() {
        
                if [[ $# < 1 ]]; then 
                        echo "Missing argument."
                        usage 
                        return 1 
                fi
        
                if [[ ! -z $shelf_list[$1] ]]; then 
        
                        unset "shelf_list[$1]"
                        typeset -p shelf_list > $SHELF_MARK_PATH
                        source $SHELF_MARK_PATH
        
                        if [[ -z $shelf_list[$1] ]]; then 
                                echo "Correctly removed mark with id '$1'."
                        else 
                                return 1
                        fi
                else
                        echo "id $1 not found."
                        return 1
                fi
        
        }
        
        list() {
        
        
        
                if [[ ${#shelf_list[@]} == 0 ]]; then 
                        echo "No ids in mark list."
                        return
                fi
        
                printf "\tID\t\tPATH\n"; 
        
                for name in "${(@k)shelf_list}"; do
                        printf "\t%s\t\t%s\n" "$name" "${shelf_list[$name]}"
                done
        
        }
        
        
        if [[ $# == 0 ]]; then 
        
                echo "No arguments supplied."
                usage
                return 1
        
        else 
                for com in "${(@k)commands_table[@]}"; do 
                        if [[ $1 == $com ]]; then 
                                $com $2 $3
                                return 0
                        fi
                done
        
                echo "Command not found."
                usage
                return 1
        fi
}
