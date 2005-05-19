From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: 4 bugs
Message-Id: <3ED8FE01.5080605@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030531161631.A400@libero.it>
In-Reply-To: <20030531161631.A400@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

all of these are correct as-is, you are mistaken.

Fabio Salvucci wrote:
> The version lm_sensors-2.7.0 don't work on my computer.
>   
> I have check the version 2.6.3-5 and 2.7.0 and I have found this difference.
>   
> When I have  modified this line of code the program work very nice.
>   
>   
> *********************************************************  
>   
> FILE lm_sensor-2.7.0/lib/access.c
> line     :225
> function :int sensor_get_feature (...etc.)  
> 
> right: if (! (main_feature->mode && SENSORS_MODE_R))
> 
> wrong: if (! (main_feature->mode & SENSORS_MODE_R))
> 
> *********************************************************
> 
>   
> *********************************************************  
>   
> FILE lm_sensor-2.7.0/lib/access.c
> line     :268
> function :int sensor_set_feature (...etc.)  
> 
> right: if (! (main_feature->mode && SENSORS_MODE_W))
> 
> wrong: if (! (main_feature->mode & SENSORS_MODE_W))
> 
> *********************************************************
>   
>   
> *********************************************************
>   
> FILE lm_sensors-2.7.0/lib/proc.c
> line     :168
> function :int sensor_read_proc (...etc.)
>     
>   
> right    :for (; mag < 0; mag --)
> 
> wrong    :for (; mag < 0; mag ++)    
> 
> *********************************************************
>   
> *********************************************************
>   
> FILE lm_sensors-2.7.0/lib/proc.c
> line     :189
> function :int sensor_write_proc (...etc.)
>     
>   
> right    :for (; mag < 0; mag --)
> 
> wrong    :for (; mag < 0; mag ++)    
> 
> *********************************************************
> 
> 
> 
> This is the output of the program on my computer : asus p4b533
> 
> 
> as99127f-i2c-0-2d
> Adapter: SMBus I801 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.58 V  (min =  +1.28 V, max =  +1.40 V)              
> VCore 2:   +1.58 V  (min =  +1.42 V, max =  +1.56 V)              
> +3.3V:     +3.40 V  (min =  +3.13 V, max =  +3.45 V)              
> +5V:       +5.11 V  (min =  +4.72 V, max =  +5.24 V)              
> +12V:     +11.59 V  (min = +10.79 V, max = +13.19 V)              
> -12V:     -12.12 V  (min = -10.79 V, max = -13.19 V)              
> -5V:       -4.59 V  (min =  -4.72 V, max =  -5.24 V)              
> CPU   fan:2537 RPM  (min = 2393 RPM, div = 4)                     
> MB    fan:2934 RPM  (min = 2800 RPM, div = 2)                     
> POWER fan:   0 RPM  (min =  750 RPM, div = 8)                     
> MB   temp:   +26?C  (limit =  +60?C)                              
> CPU  temp: +28.0?C  (limit =  +52?C, hysteresis =  +47?C)        
> vid:      +1.350 V
> alarms:   
> beep_enable:
>           Sound alarm enabled
> 
> 
> 
> 
