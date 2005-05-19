From: randhol+vim@pvv.org (Preben Randhol)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030919092203.GA14255@pvv.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote on 19/09/2003 (09:58) :
> Anyway, you're always free to edit /etc/sensors.conf and use your
> favorite formula here, as long as it works for you.

I understand. I have one tiny problem though. I want to use this
formula:

   compute temp1 (19.222-0.064912*@+0.017212*@*@), 

however I cannot compute this number back to @ as there is no sqrt
function. Why do one need to convert this number back? Can I only use @
after the comma?

Thanks in advance.

-- 
Preben Randhol ------------- http://www.pvv.org/~randhol/vim --
                 "Vim : simply the best text editor out there."
