From: Juerg Haefliger <juergh@gmail.com>
Date: Thu, 09 Dec 2010 11:18:57 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <AANLkTi=5kc2Yx=xeGA-6-i-jnpF1CJ7SoirTH_gnmtWe@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean and Jeff,

>> >> #    label temp2 "SIO Temp"
>> >
>> > This is an internal sensor, it should always be present and correct, so
>> > why would you ignore it?
>>
>> The value is high...very high. Does a flucuating value between 120 and 128
>> Celsius make sense?
>
> Indeed not. Juerg, you have the datasheet (I think?), I don't, can you
> please check if temp2 is still internal on the SCH5127?

temp2 is still the internal temp diode. Jeff, do you actually get a
value of +128? That would indicate a sensor error. Can you check if
temp2_fault reports a value of 1? It's not a sticky value so you might
have to poll it multiple times to catch it. The datasheet however is
not completely clear if the error condition only applies to the remote
sensors which would make more sense.

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
