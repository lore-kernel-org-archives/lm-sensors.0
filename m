From: dan@dogsbody.org (Dogsbody)
Date: Wed, 14 Jun 2006 12:00:47 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <448FFA6F.9050802@dogsbody.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <448F748D.5000703@dogsbody.org>
In-Reply-To: <448F748D.5000703@dogsbody.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> You are using too old version of lm-sensors. Imho you have W83627EHF 
> chip (Failed! (0x88)). Try with the latest version of lm-sensors.


Hi,

Thank you very much.  Downloaded, compiled and installed v2.10.0.  Sure enough 
It finds the W83627EHF chip but W83627EHF isn't supported yet! :-(

I was hoping to force load the w83627hf or w83781d module so that I could at 
least read the variables but I am not quite sure of the syntax for an ISA-bus 
device (magic bus number '9191')??

Driver `w83627ehf' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)

Could someone please help me with the correct modprobe command?

Thank you again for your help.

Regards, Dan

