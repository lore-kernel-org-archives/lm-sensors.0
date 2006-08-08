From: sensors@bytabok.com (Jon)
Date: Tue, 08 Aug 2006 14:56:25 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <413680bb0608080756p6a69ee39s3d290c36d946e6bf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
In-Reply-To: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/8/06, Tomislav Par?ina <tparcina at lama.hr> wrote:
> Do I need to patch Kernel to make lm_sensors work on Fedora Core 4 (2.6.11) and Via EPIA (vt1211 chip) motherboard? If yes, what patch should I use and is there any complete instructions how to do it?
>
> I have tried to use patch (this one http://hem.bredband.net/ekmlar/patch-vt1211-2.6.11.txt ) found on this pages http://hem.bredband.net/ekmlar/vt1211.html
>

Did you try compiling it as a module by doing:
patch kernel with:
patch -p1 < patch-vt1211-2.6.11.txt
copy the patched vt1211.c to your homedir or something and do:
echo "obj-m := vt1211.o" > Makefile
make -C /path/to/your/kernel2.6/source/dir SUBDIRS=$PWD modules
?
I got it working by doing that on the patched kernel (for
debian-stable with 2.6.8 but it ought to be pretty much the same)

/Jon
