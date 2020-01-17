From: David VANTYGHEM <david.vantyghem@infolib.re>
Date: Fri, 17 Jan 2020 13:54:33 +0000
Subject: Re: Is a temperature missing in sensors ?
Message-Id: <7824b66f-c6d8-a759-9dfb-e39d903cd9d7@infolib.re>
List-Id: <lm-sensors.vger.kernel.org>
References: <288394b8-1afd-0ad1-e193-69fa169d090c@infolib.re>
In-Reply-To: <288394b8-1afd-0ad1-e193-69fa169d090c@infolib.re>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Thank you for your answer.


Le 17/01/2020 à 14:42, Ondřej Lysoněk a écrit :
> Hi,
>
> David VANTYGHEM <david.vantyghem@infolib.re> writes:
>
>> Hello,
>>
>> With https://github.com/lpereira/hardinfo, I've got 6 temperatures : 1
>> for the GPU and 5 for the CPU (coretemp/temp1 to 5 and
>> thermal/thermal_zone0).
>>
>> With sensors, i've got only 5 temperatures (temp1 for GPU and Core 0 to
>> Core 3 for CPU). Is it a bug with HardInfo or is a temperature missing
>> in sensors ?
>>
>> https://framapic.org/SPID9PhB2KDJ/KaV6FdY6uvSW.png
> Hi,
>
> the 'sensors' output is missing the 'thermal/thermal_zone0' temperature,
> as shown by hardinfo. This is because lm_sensors only handles the hwmon
> subsystem (/sys/class/hwmon), not thermal (/sys/class/thermal).
>
> Ondrej
>
>> -- 
>> Signez la pétition pour le retrait du projet de réforme des retraites : https://onestla.tech
>>
>> Installer facilement Linux : http://infolib.re
>>
>>     .--.
>>    |o_o |
>>    ||_/ |
>>   //    \\    Envoyé depuis mon Linux
>>  (|      |)
>> / \_   _/ \
>> \___)=(___/

-- 
Signez la pétition pour le retrait du projet de réforme des retraites : https://onestla.tech

Installer facilement Linux : http://infolib.re

    .--.
   |o_o |
   ||_/ |
  //    \\    Envoyé depuis mon Linux
 (|      |)
/ \_   _/ \
\___)=(___/
