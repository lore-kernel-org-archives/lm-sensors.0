From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 07 Jan 2007 09:24:29 +0000
Subject: [lm-sensors] HP PAVILLION dv8000
Message-Id: <20070107102429.252095a5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
In-Reply-To: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Salatiel,

On Sat, 6 Jan 2007 22:00:49 -0300, Salatiel Filho wrote:
> Ok. sensors-detect now changed to :
> 
> #----cut here----
> # I2C adapter drivers
> # modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
> modprobe i2c-i801
> # Chip drivers
> modprobe ds1621
> modprobe eeprom
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> 
> but i still get the same error loading sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> 
> 
> One odd thing that i notice is that it doesn`t exist i2c-i801 , it
> does exit i2c_i801 so i have to change manually.

You don't have to; modprobe handles dashes and underscores as the same
character.

> any other ideas ?

I think the ds1621 is a false positive, and your hardware monitoring
chip is different. It's an old chip and easily misdetected. I think I
remember a similar report some times ago, although I can't find it
again now. You didn't tell us which version of sensors-detect you have
been trying. Please try the latest version:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
It might detect your chip better. Please include the complete output of
the script.

-- 
Jean Delvare

