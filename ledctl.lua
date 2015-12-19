-- flips the pin ON and OFF
function flip(pin)
    print(pin);
    if gpio.read(pin) == gpio.HIGH then
        --print("LOW")
        gpio.write(pin, gpio.LOW)
    else
       --print("HIGH")
        gpio.write(pin, gpio.HIGH)
    end
end

function fade(pin,speed,frequency, step)
    -- pin = 1;
    flag=1;    
        print(pwm.getduty(pin))
        print(gpio.read(pin))
    if gpio.read(pin) == gpio.HIGH or pwm.getduty(pin) > 0 then
        print ("HIGH ou >0")
        local r=1023;
        pwm.setup(pin, frequency, 1023)
        pwm.start(pin)
        tmr.alarm(3, speed, 1, function()
            pwm.setduty(pin, r)
            if flag==1 then 
                r=r-step;
                if r<0 then
                    flag = 0
                    r=0
                    pwm.close(pin)
                    gpio.mode(pin, gpio.OUTPUT)
                    gpio.write(pin,gpio.LOW)
                    tmr.stop(3)
                end
            end
            end)
    else
        --print("LOW")
        local r=0;
        pwm.setup(pin, frequency, 0)
        pwm.start(pin)
        tmr.alarm(3, speed, 1, function()
            pwm.setduty(pin, r)
            if flag==1 then 
                r=r+step;
                if r>=1023 then
                    flag = 0
                    r=1023
                    pwm.close(pin)
                    gpio.mode(pin, gpio.OUTPUT)
                    gpio.write(pin,gpio.HIGH)
                    tmr.stop(3)
                end
            end
            end)    
    end
end

--fade(pin,speed,frequency, step)
--tmr.alarm(6,5000,1,function() fade(math.random(1,6),2,1000,1) end)
--tmr.stop(6)

