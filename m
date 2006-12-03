From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 03 Dec 2006 12:33:59 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <4572C437.1050704@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sun, 03 Dec 2006 12:13:50 +0100, Udo van den Heuvel wrote:
>> Jean Delvare wrote:
>>> are ignore statements for them in your configuration file. 
>> Sure. But not for the temperatures.
>> (...)
>> chip "vt1211-*" "vt8231-*"
>> #
>> #
>> #ignore in6
>> #set config 12
>> ignore in0
>> ignore in1
>> ignore temp1
>> ignore temp2
>> ignore temp4
>> ignore temp5
>> ignore temp6
>> ignore temp7
> 
> "No, Sir, I don't have ignore statements for temperatures. I swear!"
> 
> Tsss...

As you can see the situation was edited for temp3 which was the cpu temp
sensor. All other temp sesnors are of no interest at all.
So my answer should be read as 'not for the temperatures that are
interesting'. The Tsss could show a lack of something.
You are moving way off the focus of this quest which is very clear.

>> I just see that temp sensors might have been renumbered?
> 
> Yes, they have been, and the values have been changed as well, so the
> compute statements are different.

That's very nice to do! Why oh why keep something that works?
Where can I find the very simple knowledge to build new compute
statments, my only interesting hobby?

Udo

