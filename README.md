# depthai_general_user_docker

```bash
git clone https://github.com/luxonis/depthai && cd depthai
```
```bash
docker pull pinto0309/oakd:latest

or

docker build -t pinto0309/oakd:latest .
```
```bash
xhost +local: && \
docker run --rm -it \
-v /dev/bus/usb:/dev/bus/usb \
--device-cgroup-rule='c 189:* rmw' \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
-v `pwd`:/home/user/workdir \
-w /home/user/workdir/ \
--net=host \
--privileged \
pinto0309/oakd:latest
```
```bash
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
