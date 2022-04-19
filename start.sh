# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tpierre <tpierre@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/05/09 16:29:58 by tpierre           #+#    #+#              #
#    Updated: 2020/05/09 16:30:01 by tpierre          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

docker rm -f test
docker build -t ft_serverdock:v1 .
docker run -ti -p 80:80 -p 443:443 --name test ft_serverdock:v1
