From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 30 Dec 2006 02:54:24 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4dfa50520612291854p526c7bc9x6042bcd15a2afa73@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hamlet,

On 12/29/06, Hamlet <hamletmun at fibertel.com.ar> wrote:
> Hi David.
> How can I contact with Jean and Rudolf?

Be sure to include them in the To: header, as I am doing. Then, *be*
*patient*. They're very busy. However, their information is quite
useful, so it's worth waiting. And they don't miss the messages, even
if it takes a while.

> As your advice, I checked the BIOS.
> CPU             56?C
> MB              38?C
>
> CPU             1600 RPM
> CHASSIS FAN 1   N/A
> CHASSIS FAN 2   N/A
> CHASSIS FAN 3   N/A
> POWER FAN       N/A
>
> VCORE           1.208
> 3.3V            3.280
> 5V              5.171
> 12V             12.091
>
> So I adjusted again my .gkrellm2/sensor-config
>
> sensor sensor_config_version 1
> sensor sensor_float_factor 10000
> sensor gkrellm_float_factor 1000
> sensor "MB" "w83627dhg-9191-0290/temp1" 08500 0 1 0
> sensor "CPU" "w83627dhg-9191-0290/temp2" 10000 0 1 0
> sensor "AUX" "w83627dhg-9191-0290/temp3" 10000 0 0 0
> sensor "FAN1" "w83627dhg-9191-0290/fan1" 10000 0 1 0
> sensor "CPU" "w83627dhg-9191-0290/fan2" 10000 0 1 0
> sensor "PWR" "w83627dhg-9191-0290/fan3" 10000 0 1 0
> sensor "FAN3" "w83627dhg-9191-0290/fan4" 10000 0 1 0
> sensor "FAN2" "w83627dhg-9191-0290/fan5" 10000 0 1 0
> sensor "NONE" "w83627dhg-9191-0290/in0" 10000 0 0 0
> sensor "Vcore" "w83627dhg-9191-0290/in1" 06600 0 1 0
> sensor "+3.3V" "w83627dhg-9191-0290/in2" 09960 0 1 0
> sensor "+5V" "w83627dhg-9191-0290/in3" 15680 0 1 0
> sensor "+12V" "w83627dhg-9191-0290/in4" 71500 0 1 0
> sensor "-12V" "w83627dhg-9191-0290/in5" -74500 0 0 0
> sensor "-5V" "w83627dhg-9191-0290/in6" -30950 0 0 0
> sensor "V5SB" "w83627dhg-9191-0290/in7" 10000 0 0 0
> sensor "VBat" "w83627dhg-9191-0290/in8" 10000 0 0 0
> sensor units_fahrenheit 0
> sensor volt_display_mode 0
>
> ASUS P5B Deluxe WiFi AP Edition seems to use:
>
> temp1, temp2
> fan1, fan2, fan3, fan4, fan5
> in1 (or in0 for Vcore, how can I tell?), in2, in3, in4
>
> At least, these values are shown in Asus Probe II and BIOS.
>
> The attachment is the screenshot of gkrellm2.
> It shows only those values enabled and adjusted.

This looks like the right configuration. I will refer other users
setting up the Asus P5B Deluxe WiFi AP to your message in the future.

David

