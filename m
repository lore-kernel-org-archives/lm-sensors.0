From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Fri, 12 May 2006 06:44:56 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <Pine.LNX.4.62.0605120842300.6485@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Trying to build against 2.6.16.16, I ran into undefined references to 
SENSOR_ATTR arrays. After a quick search it looks like it was introduced 
little time ago.

Do I need to upgrade to 2.6.17-rc4 or is there another separate patch to 
apply ?

Sylvain

On Thu, 11 May 2006, David Hubbard wrote:

> Hi Rudolf, Sylvain,
>
> Here is the .c file Rudolf sent me, and the first patch is his
> (add_fan_crt.patch). Then there are three patches of mine. Rudolf, I
> removed the extra comments as you suggested. Please test these and let
> me know if there are any problems.
>
> David
>
> On 5/11/06, Sylvain Jeaugey <sylvain at gomjabbar.ath.cx> wrote:
>> Hi guys,
>> 
>> I own an ASUS P5S800-VM, with an embedded W83627EHF. If you need help for
>> testing/coding, please tell me where I can find the latest piece of code.
>> I saw e-mails with patches, but didn't catch all of them. I'd really like
>> to play with smart fans ...
>> 
>> So, if I can do something, just ask.
>> 
>> Cheers,
>> Sylvain
>

