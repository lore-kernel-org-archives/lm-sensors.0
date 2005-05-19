From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: arima computations updated
Message-Id: <Pine.LNX.4.58.0405271646320.1458@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

ARIMA board update follows.

Regards

Rudolf

---------------------------

(in0+1)*231/10000

print(quotient);
reminder is handled this way:

newrem=reminder*10

if newrem<10000 then
print("0%d",reminder);
else
print(reminder);
end if

(in1+1)*231/10000
same as above.

in6*231/10000
same as above.

in2*296/10000

print(quotient);
reminder is handled this way:

newrem=reminder*10

if newrem<10000 then
print("0%d",reminder);
else
print( (reminder+600) );
end if

in5*296/10000
same as above

in3*23/1000

print(quotient);
reminder is handled this way:

do reminder/10 ;change from *

and now what I dont understand much.

print((reminderofthis*256+quotientofthis)+400)


in4*23/1000

print(quotient);
reminder is handled this way:

do reminder/10 ;change from *

and now what I dont understand much.

print((reminderofthis*256+quotientofthis)+3700)


0000AC66  58                pop ax        ;ax holds reminder
0000AC67  B30A              mov bl,0xa
0000AC69  F6F3              div bl  	  ;do reminder /10, AH reminder
0000AC6B  660FB7C0          movzx eax,ax  ;extend to 32bit
0000AC6F  6605740E0000      add eax,0xe74 ;add 3700
0000AC75  E84DCE            call 0x7ac5   ;call print
