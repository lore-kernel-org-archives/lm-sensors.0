From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041208205407.6da83bf2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It's a lost cause, I think.
> The controller is going to use the first byte for the length the slave
> intends to send. The LAST_BYTE bit means the SW telling the master it
> wants to stop. If the first byte is > 32 or doesn't match the actual
> message length I think the results are likely to be bad. 

Yeah, something like that. I'm giving it up now.

-- 
Jean Delvare
http://khali.linux-fr.org/
