# Install

`docker build -t ros-kinetic-gazebo9 .`


`docker run -it -v path/to/sim_ws:/sim_ws -e DISPLAY=$DISPLAY ros-kinetic-gazebo9`

if getting temporary failure do `docker build --network=host -t ros-kinetic-gazebo9 .`
# In Windows
Run vcsxsrv with -multiple windows, native opengl UNchecked,  additional parameters `-ac`.



