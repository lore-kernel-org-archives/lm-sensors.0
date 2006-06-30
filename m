From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 30 Jun 2006 08:48:02 +0000
Subject: [lm-sensors] Support for Intel 82801GR (ICH7 Family)
Message-Id: <44A4E542.8020400@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A125CA.3000603@correiolivre.serpro.gov.br>
In-Reply-To: <44A125CA.3000603@correiolivre.serpro.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

andre.dantas-vieira at serpro.gov.br wrote:
> Hi all,
> I'm trying to install lm_sensors on my system with a Intel 82801GR. I 
> searched on the "Supported Busses and Chips" page, "New Drivers" page 
> and "lm_sensors CHANGES file" and didn't found that 82801GR/ICH7R is 
> supported or not. When i run sensors-detect at the first step on probing 
> for PCI bus adapters i have to use 'i2c-i801' for device ICH7.
> 
> ---------------- Begin Output ---------------------------------------
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
> Probe succesfully concluded.

This means that it works. Perhaps there are no known devices on the bus?

Please try:
modprobe i2c-dev
modprobe i2c-i801
i2cdetect 0

(0 is the bus number, assumiing there are no other i2c busesses on the system
with loaded drivers you may check the list with i2cdetect -l)

Regards
Rudolf

