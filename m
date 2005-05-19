From: philpi@apu.edu (Phillip Pi)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Quick Question: How do I turn off beep_enable alarm?
Message-Id: <Pine.LNX.4.44.0212020826160.2745-100000@home.apu.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ah thanks. I thought there was a global setting. I checked my other Linux 
box and its sensors.conf doesn't have ignore beep_alarm lines anywhere. 
Yet, sensors v2.6.1 command shows: 

beep_enable:
          Sound alarm disabled


Did I miss something?
-- 
"I got this aunt... Carpenter ant." --Girl and Crow
  /\___/\
 / /\ /\ \        Phillip Pi (Ant); The Ant Farm: http://antfarm.ma.cx
| |o   o| |
   \ _ /                E-mail: philpi@apu.edu or philpi@earthlink.net
    ( )

On Mon, 2 Dec 2002, Jean Delvare wrote:

> 
> > Thanks. What did you mean by adapter section?
> 
> Lines that begin with "chip" in sensors.conf delimit the adapter
> sections. So you have to add the line in the right section if you want
> it to work for you.
