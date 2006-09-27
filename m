From: r.marek@assembler.cz (Rudolf Marek)
Date: Wed, 27 Sep 2006 16:49:00 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <451AAB7C.2010008@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK, I will be glad to test further.
>   

Ok I think I found it.:

Please change this:
             do_rdmsr(data->id, MSR_IA32_THERM_CONTROL, &eax, &edx);

Into this:

             do_rdmsr(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);

It should work ...

Thanks,

Rudolf



