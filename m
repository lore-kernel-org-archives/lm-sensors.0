From: biertrinken@web.de (Tobi Gschwendtner)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: lm_sensors with kernel 2.5.72
Message-Id: <3F06EB5B.4050603@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030705165156.4a7b525e.khali@linux-fr.org>
In-Reply-To: <20030705165156.4a7b525e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I'd like to subscribe to your mailing list!
>>my email address is biertrinken@web.de
>>    
>>
>
>Are you sure you want this? The list is intended for developpers, not
>users. There's almost nothing you will want to read unless you are
>writing a driver or tool that is somehow related to our project. 
>
>If you simply have a question as a user, just ask and you'll explicitely
>be added to the recipients on replies.
>
>  
>
sorry, didn't  kniow that.

my question is about setting up lm_sensors with kernel 2.5.72.
my lsmod looks like this:


Module                  Size  Used by
sd_mod                  9056  0
usb_storage            40000  0
uhci_hcd               21448  0
sg                     23628  0
vfat                    8768  0
fat                    34848  1 vfat
usbcore                70868  4 usb_storage,uhci_hcd
i2c_viapro              3020  0
w83781d                23488  0
via686a                12036  0
i2c_sensor              1664  2 w83781d,via686a
i2c_dev                 5120  0
tuner                  11652  0
tvaudio                16128  0
msp3400                18832  0
bttv                   81024  1
video_buf              11008  1 bttv
i2c_algo_bit            7816  1 bttv
i2c_core               13636  10 
i2c_viapro,w83781d,via686a,i2c_sensor,i2c_dev,tuner,tvaudio,msp3400,bttv,i2c_algo_bit
v4l2_common             2560  1 bttv
videodev                3648  2 bttv
snd_via82xx            10240  1
snd_ac97_codec         39620  1 snd_via82xx
snd_mpu401_uart         3200  1 snd_via82xx
snd_rawmidi            13440  1 snd_mpu401_uart
snd_seq_device          4228  1 snd_rawmidi
snd_pcm_oss            38916  0
snd_pcm                60160  2 snd_via82xx,snd_pcm_oss
snd_page_alloc          4420  2 snd_via82xx,snd_pcm
snd_timer              14464  1 snd_pcm
snd_mixer_oss          12992  2 snd_pcm_oss
snd                    29508  9 
snd_via82xx,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
ide_scsi                9664  0
3c59x                  24424  0

but sensors ( executed as root ) says:

Can't access /proc file
/proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
Make sure you have done 'modprobe i2c-proc'

i'm using sensors version 2.7.0

thanks

tobi

