From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Dec 2006 09:06:33 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <20061224100633.271744cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4568C502.6070305@lymenet.org>
In-Reply-To: <4568C502.6070305@lymenet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Fri, 22 Dec 2006 14:11:40 -0800, Juerg Haefliger wrote:
> Well, I happen to work for HP, different organization though. But
> we're about to be using the DL385 out of ISS to integrate into our
> product line. We'll be running Debian and we need to be able to read
> temp and fan information but we'll rely on hp tools to get there (not
> my choice). Anyways, we might have a business need to get the source
> and I might be able to pass some information along. No promise though
> since we're pretty uptight about those things (not my choice either).
> 
> Anyways, let me know what you want to know and I'll see what I can do...

Thanks for the proposal. Basically we want to know what hardware
monitoring chips are used in the system, and how they are wired. I
suspect that HP uses a non-standard I2C bus, possibly GPIO-driven.

Thomas, I've thought a bit more about your problem, and I'm now almost
certain that you won't find anything attached to your motherboard's
SMBus, even if you upgrade the BIOS or force the SMBus base address.
You said that the "hplog" utility was printing temperature values, so
it must get them from somewhere, and it definitely can't get them from
anything connected to the currently disabled SMBus. So there has to be
another, non-standard I2C bus somewhere on the board.

-- 
Jean Delvare

