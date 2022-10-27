# depthai_general_user_docker

```
docker pull pinto0309/oakd:latest

or

docker build -t pinto0309/oakd:latest .
```

```
python3 depthai_demo.py
```

https://user-images.githubusercontent.com/33194443/198327250-17cbb3aa-57c7-4f20-8024-03cd3e3483ae.mp4

```
sudo chown -R user /etc/udev/rules.d \
&& sudo /lib/systemd/systemd-udevd --daemon \
&& sudo udevadm control --reload-rules \
&& sudo udevadm trigger \
&& sudo chown -R user /dev/bus \
&& sudo chmod -R 0777 /dev/bus
```
