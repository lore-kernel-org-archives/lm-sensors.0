From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 07 Sep 2006 16:08:55 +0000
Subject: [lm-sensors] regression test script for sensors output
Message-Id: <45004417.1070203@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F72B6D.4050207@gmail.com>
In-Reply-To: <44F72B6D.4050207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Jim:
>
> * Jim Cromie <jim.cromie at gmail.com> [2006-08-31 12:33:17 -0600]:
>   
>> attached script reads `sensors` output, compares to file content
>> (which should contain sensors output from baseline driver, before you hack)
>>     
>
> Hey, thanks for doing that - it will be useful.
>
>   
thanks. 
It may not work well for cases with 2+ chips being reported, since I dont
have such a mobo, but its probably extensible w/o much effort.
(anybody want to post such ouput ?)
I didnt try to reduce it to yes/no tests, which is what most of perl's 
Test::* modules do.


> Do you have any experience with these Perl modules... ?
>
> 	test::cmd
> 	test::simple
> 	test::harness
>
>   
one word version - yes.

http://search.cpan.org/~knight/Test-Cmd-1.05/Cmd.pm
last updated in 2001, but given its tight focus on testing executables,
I dont see its age as a problem.  The Doc at the link is good.

http://search.cpan.org/~mschwern/Test-Simple-0.64/lib/Test/Simple.pm
slightly simpler version of test code used to validate perl itself, which
is well developed and mature (100K tests, and increasing..)

http://search.cpan.org/~petdance/Test-Harness-2.62/lib/Test/Harness.pm
This is more infrastructure stuff, you dont need it until you need more than
Test::Simple, Test::More do by themselves ( Harness complements them, 
not replaces them)


http://search.cpan.org/~mschwern/Test-Simple-0.64/lib/Test/Tutorial.pod
good orientation to the perl Test::* facilities

> I'm working up a regression test for the libsensors config file scanner.  At
> the moment, Perl with those modules looks like an easy but flexible way to
> organize it. 
Id agree with that.

Is the scanner observable & controllable at a unit level ?

Let me elaborate by example...

* my regression script tests end-to-end;
driver + sysfs-interface + sensors read of it --> results (saved to file)
It wont tell you where things may be broken.
I thought briefly about testing the attr-files directly, but punted once
I saw that the /sys/<path> to use wasnt entirely obvious from the 
sensors output.

soekris:~# sensors
pc87366-isa-6620
Adapter: ISA adapter
VS
soekris:/sys/devices/platform/i2c-9191/9191-6620#
IOW, I didnt see a 1:1 between the former and "2c-9191/9191-6620"

*  I could have made my script more testable by accepting 2 files of 
sensors output
and testing them for 'equivalence', rather than running `sensors` for 
live data.


So, back to the scanner ..
Its 'output' is an expression tree in memory thats used to compute 
user-facing
numbers by sensors, ie its not directly observable, except insofar as it 
affects
sensors output.

What are you looking to test ?
- that scanner rejects bad configs ?
- that changes in the config-file input yield commensurate changes in 
sensors output ?
- that setting alarm thresholds below/above current measurements results 
in 'ALARM's ?
- etc ..

>  By contrast, Dejagnu is extreme overkill.  Are there any other
> mechanisms I should consider?
>   
If youre looking for non-perl test tools, there are probly many,
but I dont know any of them.  For me, perl is enough.

> Thanks & regards,
>
>   


