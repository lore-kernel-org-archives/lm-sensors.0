From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Mon, 06 Oct 2008 15:00:04 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h and
Message-Id: <20081006150004.GL22162@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 02, 2008 at 12:20:38AM +0200, Rudolf Marek wrote:
> I finally had time to add support to k8temp  for the new family 10h and family
> 11h of CPUs.
> 
> The patch adds support for new fam10h and fam11h CPUs (aka Phenom and new 45nm
> CPUs). The patch was tested on K8 fam 0fh revE and revF CPU. I dont know if it
> works at all on new CPUs. Please test. You should see the max temp (always 70C
> and one temperature per CPU). Of course test is on your own risk ;)
> 
> Andreas, please is TcontrolMax also 70C for fam 11h CPUs?

Hmm, the "Power and Thermal Data Sheets" don't provide this info.
I'll check this asap. 

.. and I'll test your stuff in the next few days.


Regards,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
