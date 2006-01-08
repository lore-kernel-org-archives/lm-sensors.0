From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 08 Jan 2006 13:50:48 +0000
Subject: [lm-sensors] Lmsensors and Asus CUSL2
Message-Id: <43C118B8.4070106@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c6142c$ec8c6be0$0200a8c0@administrator>
In-Reply-To: <000301c6142c$ec8c6be0$0200a8c0@administrator>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Danke f?r deine schnelle Antwort!

Kein Problemm.

> Das du wie ich sehen kann gut deutsch kannst schreibe ich jetzt auch
> einfach mal auf deutsch... ;)
>  
> Also bei mir handelt es sich um die Kernel-Version : *2.4.31 #1 Sun Nov
> 6 21:51:04 GMT 2005 i686* Und bei Lmsensors um die Version: *sensors
> version 2.9.1 with libsensors version 2.9.1*
> ** 
> ** 

Danke.

> /Driver `w83781d' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at e800' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x2d (and 0x48 0x49)
>     Chip `Asus AS99127F (rev.1)' (confidence: 8)/
> // 
> /Driver `ds1621' (may not be inserted):
>   Misdetects:
>   * Bus `SMBus I801 adapter at e800' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x48
>     Chip `Dallas Semiconductor DS1621' (confidence: 3)
>   * Bus `SMBus I801 adapter at e800' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x49
>     Chip `Dallas Semiconductor DS1621' (confidence: 3)/
> //root at ipcop:/tmp/lmsensors/ <mailto:root at ipcop:/tmp/lmsensors>/ #/
> // 
> Und wenn ich auf der IPCop oberfl?che bin und mal in das Sensoren Men?
> gehe sehe ich Folgendes:
>  
> *root at ipcop : / #** show lmsensors *
> 
> as99127f-i2c-0-2d
> Adapter: SMBus I801 adapter at e800
> VCore 1:   +1.81 V  (min =  +1.66 V, max =  +1.82 V)              
> VCore 2:   +1.81 V  (min =  +1.66 V, max =  +1.82 V)              
> +3.3V:     +3.52 V  (min =  +3.14 V, max =  +3.46 V)       ALARM  
> +5V:       +5.06 V  (min =  +4.74 V, max =  +5.24 V)              
> +12V:     +11.67 V  (min = +10.83 V, max = +13.19 V)              
> -12V:     -12.08 V  (min = -13.23 V, max = -10.73 V)              
> -5V:       -5.06 V  (min =  -5.25 V, max =  -4.74 V)              
> fan1:     3813 RPM  (min =    0 RPM, div = 2)                     
> fan2:        0 RPM  (min =    0 RPM, div = 2)                     
> fan3:        0 RPM  (min =    0 RPM, div = 2)                     
> M/B Temp:    +21 C  (high =  +105 C, hyst =    +0 C)          
> CPU Temp:   -1.0 C  (high =  +100 C, hyst =   +92 C)          
> temp3:     -31.5 C  (high =  +122 C, hyst =  +121 C)          
> vid:      +1.750 V  (VRM Version 8.2)
> alarms:   
> beep_enable:
>           Sound alarm enabled
> 
> Weist du was ich noch machen kann?

Du kannst versuchen richtiges CPU temperatur gewinnen.
Finde diese Zeile im /etc/sensors.conf
#   compute temp2 (@*30/43)+25, (@-25)*43/30

Und # weg schmeisssen so:
compute temp2 (@*30/43)+25, (@-25)*43/30

Spare die Datei.
Dann musst du sensors -s laufen und dan wieder sensors
Die CPU temperatur soll Gut sein.

Du kannst auch andere Programme die lm-sensors nutzen probieren, versuch ein bisschen googeln.

Ich hoffe es wird helfen.

Tsch?ss
Rudolf

