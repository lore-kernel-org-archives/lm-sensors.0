From: Rudolf Marek <rudolf.marek@sysgo.com>
Date: Mon, 03 Sep 2007 10:36:46 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <46DBE3BE.2060207@sysgo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Bernhard!

Sooo... the 49 needs to be substracted even from the LSB bits! Does it 
really work then ;) ? If so then cool,
I will find out what are the CPUIDs for the revF.
> The formula has changed indeed, see page 181 of: 
>
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
>
> I wrote a quick and dirty patch. It works for me on both an old Sempron
> and a Brisbane, but it's not yet production quality ;)
>
> It uses the cpuid "100mhzsteps" flag to decide which formula to use,
> because I couldn't find any information about existing cpuid "model"
> values.
>   
I think I overseen that information, I simply though that the 
temperature will be just truncated to nearest degC.

Please CC the list too. Unfortunately I dont know if I will be online in 
the evening, I moved to flat and still no internet.
For the CPUID range of revF I would suggest to check the
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/33610.pdf

Page 7, I think you may use > operator in IF to check if CPUID is bigger 
or equal than first CPUID of the revF series.

Gotta work now ;)



-- 

S přátelským pozdravem / Best regards / Mit freundlichen Grüßen

Ing. Rudolf Marek
SYSGO s.r.o.
Zelený pruh 99
CZ-14800 Praha 4
Phone: +420 222138 627, +49 6136 9948 627
Fax: +420 296374890, +49 6136 9948 1 627
rudolf.marek@sysgo.com

http://www.sysgo.com | http://www.elinos.com | http://www.pikeos.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
