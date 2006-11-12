From: tux@tuxslare.org (=?ISO-8859-1?Q?Andr=E9_Lemos?=)
Date: Sun, 12 Nov 2006 20:04:45 +0000
Subject: [lm-sensors] fan control - w83627hf
Message-Id: <45577E5D.80905@tuxslare.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4556E7ED.8020504@sh.cvut.cz>
In-Reply-To: <4556E7ED.8020504@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm having some trouble with fan control on a VIA chipset board (using 
the module w83627hf).

I get the following information when running pwmconfig:

Found the following PWM controls:
   9191-0290/pwm1
   9191-0290/pwm2

Found the following fan sensors:
   9191-0290/fan1_input     current speed: 1985 RPM
   9191-0290/fan2_input     current speed: 3835 RPM

when trying to stop them:

Testing pwm control 9191-0290/pwm1 ...
  9191-0290/fan1_input ... speed was 1985 now 2008
    no correlation
  9191-0290/fan2_input ... speed was 3835 now 3924
    no correlation


Where does the problem lie? Is it a problem with the board? What can I 
do to add support?


Thanks


Ps.: please CC me if/when replying to the list


Rudolf Marek wrote:
> Andr? Lemos wrote:
>> would it be trivial to add fan control to w83627hf as well?
>
> I think it already has fan control. What kernel? Did you tried some 
> recent?
> Please CC to list.
>
>
> Regards
> Rudolf


