From: ymu@Winbond.com.tw (Yuan Mu)
Date: Mon, 15 May 2006 01:02:02 +0000
Subject: [lm-sensors] Newbie help
Message-Id: <4467D30A.60309@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY113-W7FF2DFDEDE7A866B1CE20F0AD0@phx.gbl>
In-Reply-To: <BAY113-W7FF2DFDEDE7A866B1CE20F0AD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Paul Wagner wrote:
> I am not new to linux but I am new to lm-sensors
> 
> The sensors.conf file has me completely lost
> 
>  
> 
> I have Fedora Core 5 running on a Abit IS7-E w/ Intel 82865PE (MCH) + 
> 82801EB (ICH5) chipset
> 
> I installed using "make user" and "make user_install"
> 
> added library path to ld.so.conf and ran ldconfig
> 
> ran sensor -detect w/the following results
> 
>  
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> To load everything that is needed, add this to some /etc/rc* file:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe w83627hf
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> #----cut here----
> 
>  
> 
> I am lost from here as I do not understand the conf file
> 
> also along the line it told me to Copy prog/init/lm_sensors.init to 
> /etc/rc.d/init.d/lm_sensors
> 
>  
> 
> but there is no /prog dir
> 
>  
It's ./prog not /prog
If you just press enter to all questions sensors-detect asked you, it should have been done by the script.
Now you can try "service lm_sensors start", and use "sensors".




Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

