mooseinit = 2000;
wolfinit = 60;

moose(1) = mooseinit;
wolf(1) = wolfinit;

weakNaturalGrowth = 0.25;
weakEaten = 0.001;
strongEating = 0.0001;
strongNaturalGrowth = 0.1;

dmoose(1) = moose(1)*weakNaturalGrowth - weakEaten*moose(1)*wolf(1);
dwolf(1) = strongEating*moose(1)*wolf(1) - strongNaturalGrowth*wolf(1);

iteration = 3000;
h = 0.1
for i = 1:iteration
moose(i+1) = moose(i) + h*(moose(i)*weakNaturalGrowth - weakEaten*moose(i)*wolf(i));
wolf(i+1) = wolf(i) + h*(strongEating*moose(i)*wolf(i) - strongNaturalGrowth*wolf(i));
%moose(i+1) =  moose(i) + dmoose(i);
%wolf(i+1) = wolf(i) + dwolf(i);
end

plot(moose)
hold on
plot(wolf)