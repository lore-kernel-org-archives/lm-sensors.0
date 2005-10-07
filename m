From: tonu@jes.ee (Tonu Samuel)
Date: Fri, 07 Oct 2005 23:15:49 +0000
Subject: [lm-sensors] PCA9539 patch to support PCA9538  - please comment
Message-Id: <200510080015.10318.tonu@jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

Did some work on adding PCA9538 support. This is again some 8-bit IO chip 
which is nearly identical to PCA9539 whose support already exists in kernel. 
I had just to modify slightly some stuff. I am going through it and will test 
it with hardware tomorrow but I need your comments! Not sure if my coding 
style etc fits your rules. So, please tell something. Patch is:

http://www.jes.ee/~tonu/pca9539.patch


Some example output:

test:/usr/src/se95 # modprobe pca9539
test:/usr/src/se95 # !ca
cat /sys/bus/i2c/devices/0-0073/name
pca9538
test:/usr/src/se95 # cat /sys/bus/i2c/devices/0-0073/
bus/        direction0  driver/     input0      invert0     name        
output0     power/
test:/usr/src/se95 # cat /sys/bus/i2c/devices/0-0077/
bus/        direction1  input0      invert0     name        output1
direction0  driver/     input1      invert1     output0     power/
test:/usr/src/se95 # cat /sys/bus/i2c/devices/0-0077/name
pca9539
test:/usr/src/se95 #         


  Tonu
