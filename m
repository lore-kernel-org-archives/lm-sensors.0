From: king.br@gmail.com (Brett King)
Date: Mon, 12 Feb 2007 09:04:35 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <8cf253380702120104x4fef4abbme28c922e7d4894f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Success !
Thanks a great deal David, I couldn't have got this working without
your expertise - you are indeed a credit to the community.

# modprobe w83627ehf
# sensors
w83627dhg-isa-0290
Adapter: ISA adapter
in0:       +1.26 V  (min =  +0.00 V, max =  +1.74 V)
in1:       +1.86 V  (min =  +1.30 V, max =  +0.30 V) ALARM
in2:       +3.30 V  (min =  +0.54 V, max =  +0.56 V) ALARM
in3:       +3.30 V  (min =  +2.26 V, max =  +2.08 V) ALARM
in4:       +1.99 V  (min =  +0.08 V, max =  +0.06 V) ALARM
in5:       +1.62 V  (min =  +1.10 V, max =  +0.56 V) ALARM
in6:       +1.98 V  (min =  +0.00 V, max =  +1.18 V) ALARM
in7:       +3.30 V  (min =  +2.21 V, max =  +2.08 V) ALARM
in8:       +1.28 V  (min =  +2.05 V, max =  +0.03 V) ALARM
fan1:        0 RPM  (min = 12500 RPM, div = 4) ALARM
fan2:     2235 RPM  (min = 2986 RPM, div = 4) ALARM
fan3:        0 RPM  (min = 10227 RPM, div = 4) ALARM
fan4:        0 RPM  (min = 225000 RPM, div = 2) ALARM
fan5:        0 RPM  (min = 4821 RPM, div = 4) ALARM
temp1:       +34?C  (high =   +73?C, hyst =   +42?C)
temp2:     +54.5?C  (high = +80.0?C, hyst = +75.0?C)
temp3:    +124.5?C  (high = +80.0?C, hyst = +75.0?C)   ALARM

#

Cheers.

On 2/8/07, David Hubbard <david.c.hubbard at gmail.com> wrote:
> Hi Brett,
>
> I am sending you the patch and the full driver.
>
> It's actually pretty easy to use the patch. You just cd into your
> kernel directory, say /usr/src/linux-2.6.18
>
> # cd /usr/src/linux-2.6.18
> linux-2.6.18 #
>
> Then you run 'patch' like this:
>
> linux-2.6.18 # patch -p1 -i
> /home/yourdirectory/somepath/w83627ehf_add_w83627dhg_support.patch.txt
>
> It will tell you it is patching drivers/hwmon/w83627ehf.c and then you
> have the driver installed and ready to go.
>
> linux-2.6.18 # make
> linux-2.6.18 # make modules_install
>
> Any other kernel compile steps would go here. If you are lucky, you
> won't even need to reboot. The new module will overwrite the old
> w83627ehf.ko and you can just load the new module like this:
>
> linux-2.6.18 # modprobe w83627ehf
>
>
> Finally, the original patch is at this link with all the same information.
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018519.html
>
> Hope that helps,
> David
>
>

