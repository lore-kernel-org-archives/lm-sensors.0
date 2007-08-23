From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 23 Aug 2007 05:25:47 +0000
Subject: Re: [lm-sensors] lm-sesors on vostro 1500 please help
Message-Id: <191fb4ca0708222225w727bdf93l58623b7559c83672@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9cedb0eb0708221121n796e9c05w2d2ed5537df5bcfc@mail.gmail.com>
In-Reply-To: <9cedb0eb0708221121n796e9c05w2d2ed5537df5bcfc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/22/07, David Boss <spacem0nkey411@gmail.com> wrote:
> (01:01:46 PM) saru411: hello again...finally off of school so time to try to
> get lm-sensors installed.i have run sensors-detect and have gotten this...
> (01:02:12 PM) saru411: # I2C adapter drivers
> (01:02:12 PM) saru411: # modprobe unknown adapter NVIDIA i2c adapter 0 at
> 1:00.0
> (01:02:12 PM) saru411: # modprobe unknown adapter NVIDIA i2c adapter 1 at
> 1:00.0
>  (01:02:12 PM) saru411: # modprobe unknown adapter NVIDIA i2c adapter 2 at
> 1:00.0
>  (01:02:12 PM) saru411: i2c-i801
> (01:02:12 PM) saru411: # Chip drivers
> (01:02:12 PM) saru411: eeprom
> (01:02:12 PM) saru411: # no driver for Smart Battery Charger yet
>  (01:02:12 PM) saru411: # Warning: the required module smartbatt is not
> currently installed
>  (01:02:12 PM) saru411: # on your system. For status of 2.6 kernel ports
> check
> (01:02:12 PM) saru411: #
> http://www.lm-sensors.org/wiki/Devices. If driver is built
>  (01:02:12 PM) saru411: # into the kernel, or unavailable, comment out the
> following line.
>  (01:02:12 PM) saru411: smartbatt
> (01:03:38 PM) saru411: the next step is to edit /etc/rc.d/xxxx but i dont
> see /rc.d .. i have rc0.d
> (01:04:08 PM) saru411: rc1.d rc2.d rc3.d rc4.d rc5.d and rc6.d
> (01:04:30 PM) saru411: which one am i suppose to edit and what file do i
> edit in the folder

I don't even know where to start: output of lspci, motherboard model,
kernel version, sensors version, output of sensors-detect, ...
You have to provide some useful information if you want help.

...juerg




> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
