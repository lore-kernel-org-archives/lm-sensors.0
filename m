From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 27 May 2005 20:41:55 +0000
Subject: [lm-sensors] Query: what chance to get scaled voltages into
Message-Id: <cnie91td9ofqnqcpm6ahakr4782n0kcs3v@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <b6qc91dgk33k2ucv21du0aqsqbk3egj389@4ax.com>
In-Reply-To: <b6qc91dgk33k2ucv21du0aqsqbk3egj389@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Fri, 27 May 2005 16:48:47 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
>
>Thinking about it, I am not even sure this is a problem we want to fix.
>Mixing scaled and unscaled values within the same driver is likely to
>make this driver more complex. Did you try?

Yes, it works, right now.  Plus I simplified the scaling macro mess, 
that might be in eyes of beholder, looks neater to me :)  
>
>                                                  Whatever, you should
>really provide concrete examples (or even a complete list) when stating
>that something is broken.

Been there done that, seems unwanted.  

--Grant.

