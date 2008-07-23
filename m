From: Agile Aspect <agile.aspect@gmail.com>
Date: Wed, 23 Jul 2008 19:15:57 +0000
Subject: Re: [lm-sensors] temperature monitor
Message-Id: <4887836D.9080104@GMail.COM>
List-Id: <lm-sensors.vger.kernel.org>
References: <487CCD71.8000909@GMail.COM>
In-Reply-To: <487CCD71.8000909@GMail.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Frank Phillips wrote:
> On Tue, Jul 15, 2008 at 11:16 AM, Agile Aspect <agile.aspect@gmail.com> wrote:
>   
>> Hi - I'm new to lm_sensors and I'm trying to monitor the temperature on
>> a 8 CPU (Intel Xeon CPU X5460  @ 3.16GHz) running CentOS 4.4
>> (2.6.9-42.ELsmp.)
>>     
>
> Most likely your lm_sensors package predates your motherboard and CPU.
> A common problem for CentOS users.
> Try running this:
>
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
>
> It should tell you you need coretemp, fb-dimm, and maybe ipmisensors.
>
> Frank
>   

Hi Frank - just returned from vacation - thanks for the reply.

Here's the summary of the sensors that 'sensor-detect' detected:

    Detects correctly:
  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)

However,  it indicated

    Intel AMB FB-DIMM thermal sensor...                         Success!
    (driver `to-be-written')

Does this imply I'm out of luck?

-- Ken



-- 
Article. VI. Clause 3 of the constitution of the United States states: 

"The Senators and Representatives before mentioned, and the Members of 
the several State Legislatures, and all executive and judicial Officers, 
both of the United States and of the several States, shall be bound by 
Oath or Affirmation, to support this Constitution; but no religious Test 
shall ever be required as a Qualification to any Office or public Trust 
under the United States." 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
