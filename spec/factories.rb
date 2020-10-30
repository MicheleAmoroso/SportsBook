# coding: utf-8
FactoryBot.define do   
  factory :user, class: User do
    username        {"Test"}
    email           {"test@mail.it"}
    password        {"test1234"}
  end
  factory :ground, class: Ground do
    title           {"Test"}
    price           {1}
    ratingNum       {0}
    ratingSum       {0}
    city            {"Roma"}
    address         {"Via Roma, 25"}
    description     {"DescrizioneTest"}
    category        {"C"}
  end
  factory :review, class: Review do
    rating          {0}
    comments        {"Bel campo"}
  end
  factory :timetable, class: Timetable do
    day             {"Lunedì"}
    from            {20}
    to              {21}
  end
end
