From: Martin Herrman <martin.herrman@gmail.com>
Date: Wed, 08 Jan 2014 20:54:20 +0000
Subject: [lm-sensors] Some questions from first user
Message-Id: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

my apologies if I bother you with simple noob questions in this mail.
On the other hand, if so they should be easy to answer :-)

My mainboard is a Gigabyte GA-Z68MX-UD2H-B3 which has a iTE IT8728 and
core i5 2500T (sandy bridge).

Unfortunately this board is not (yet :-)) on the list yet:

http://lm-sensors.org/wiki/Configurations/Gigabyte

So I'm trying to understand and optimize the output of sensors using a
file in /etc/sensors.d/

My questions:
1. coretemp outputs 5 temperatures. The last 4 are the cores, but what
is the value of the first one? (my guess: the temperature of the
highest core)

2. coretemp temperatures have (according to sensors -u) a _max, _crit
and _crit_alarm. How are these values determined? Does lm_sensors have
a database of existing cpu's and their max temperature specifications?

3. (follow-up on Q2) what is the difference between _max and _crit?
What happens when each of them is reached? What is the role of
_crit_alarm and how will the alarm be noticed?

4. (follow-up on Q3) how can I change the values for _max and _crit? I
tried 'set temp1_max 60' but that doesn't work. (sensors -s complains)

5. what is the difference between fan1_alarm and fan1_beep?

6. (follow-up on Q5) how do I set fan1_alarm? set fan1_alarm 1 doesn't
work. (sensors -s complains)

7. it8728 reports 3 different temps. When CPU is at full load, one of
them increases, but the value is much lower than the one reported by
coretemp (about 10 degrees lower). sensors outputs that it is Intel
PECI. According to the explanation on Wikipedia
(http://en.wikipedia.org/wiki/Platform_Environment_Control_Interface)
the temperature should be negative and increase towards 0 when cpu
temperature rises. Why does sensors show different values?

8. it8728 shows another two temps. Likely one case temp and the other
one the south bridge? How can I find out?

9. (from FAQ) "Do you have a database of sensors.conf entries for
specific boards?
No. Good idea though. If you would like to set one up on your website
send us mail and we will set up a link to it."
Why hasn't this been setup yet? Some sort of a database is at the
wiki, but doesn't contain many boards. Is any help still appreciated?
Is it just a table of manufacturer, type, sensors.conf file? (and
maybe some user registrations and comments by registered users?)

Thanks in advance for your help!

Martin

P.S. if answers can be found somewhere.. please let me know where to
find the documentation!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
