From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: "Can't access procfs/sysfs file", but all seems ok ??
Message-Id: <41CF5B88.6090709@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5799c4e904122605035c3fde7a@mail.gmail.com>
In-Reply-To: <5799c4e904122605035c3fde7a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We'll consider it but frankly the error message sensors prints out

	"For 2.6 kernels, make sure you have mounted sysfs"

seems to work for most people :)

Szakats Istvan wrote:
> On Sun, 26 Dec 2004 13:28:39 -0500, Mark Studebaker <mds4@verizon.net> wrote:
> 
>>mount none -t sysfs /sys
> 
> 
> Wow! thanks a lot for the quick reply and it solved the whole thing
> too. 10X!!! ;)
> Just one thing though: I failed to find this in the faq. Could you put
> this mount command where it deals with the error i've had?
> 
> Happy holidays!
> Steven
> 
