echo "choose a container"
read container

podman generate systemd \
        --start-timeout=60        \
        --stop-timeout=60       \
        --restart-policy=always \
        $container > $container.service

echo "push to systemd?"

read answer


list=$(ls /etc/systemd/system/$container.service )

if [[ $list = "/etc/systemd/system/$container.service" ]]; then

        echo "service with this name already exists, removing..."
        sudo rm /etc/systemd/system/$container.service
        sudo rm $HOME/.config/systemd/user/$container.service
fi


if [[ $answer != "y" ]]; then

        echo "exiting..."

        exit
fi

sudo cp $container.service /etc/systemd/system/
sudo cp $container.service $HOME/.config/systemd/user/

sudo systemctl daemon-reload
echo ""
systemctl --user enable --now $container.service

