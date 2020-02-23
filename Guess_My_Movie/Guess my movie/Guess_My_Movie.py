#     This code belongs to NinaM31
#     This code is subject to change for further improvements

import pickle


class NodeQuestion(object):
    def __init__(self, question, is_question):
        self.question = question
        self.isQuestion = is_question
        self.yes = None
        self.no = None
        self.category = ""
        self.timesGuessedRight = 0

    @staticmethod
    def copy(q):
        copy = NodeQuestion(q.question, q.isQuestion)
        copy.yes = q.yes
        copy.no = q.no
        return copy


class Memory(object):
    firstQuestion = None
    currentQuestion = None

    # This method starts the root with Animation
    def beginning(self, first_q, category):
        self.firstQuestion = NodeQuestion(first_q, True)
        self.currentQuestion = self.firstQuestion
        self.currentQuestion.category = category

    # This method is responsible for asking questions
    def ask(self):
        if not self.currentQuestion.isQuestion:
            print("Is the name of the movie " + self.currentQuestion.question + "?")
        else:
            print(self.currentQuestion.question)
        print("N:no     Y:yes     X:exit")

    # This method will check if the guess was correct in not then it will continue to the next question by returning c
    def if_won(self, yes):
        if (self.currentQuestion.yes is None and yes == 'y') or (self.currentQuestion.no is None and yes == 'n'):
            if self.currentQuestion.isQuestion:
                return 'n'
        if not self.currentQuestion.isQuestion and yes == 'y':
            return 'y'
        elif not self.currentQuestion.isQuestion and yes == 'n':
            return 'n'
        return 'c'

    def next_question(self, move):
        if self.currentQuestion.yes is not None and move:
            self.currentQuestion = self.currentQuestion.yes
        elif self.currentQuestion.no is not None:
            self.currentQuestion = self.currentQuestion.no

    def learn(self, movie, question, answer, category, ans):
        if not question.endswith("?"):
            question = question + " ?"
        global first
        global category_q
        first = ''
        category_q = ""
        if category_q != "":
            first = category[0].lower()
            if first == 'a' or first == 'u' or first == 'i' or first == 'e' or first == 'o':
                first = 'an'
            else:
                first = 'a'
            category_q = "Is it" + first + category + " movie ?"
        if self.currentQuestion == self.firstQuestion:
            if ans == 'y':
                self.currentQuestion.yes = NodeQuestion(question, True)
                self.currentQuestion = self.currentQuestion.yes
                self.memorize(answer, None, movie)
            else:
                self.currentQuestion.no = NodeQuestion(category_q, True)
                self.currentQuestion = self.currentQuestion.no
                self.currentQuestion.yes = NodeQuestion(question, True)
                self.currentQuestion.category = category
                self.currentQuestion = self.currentQuestion.yes
                if answer == 'y':
                    self.currentQuestion.yes = NodeQuestion(movie, False)
                else:
                    self.currentQuestion.yes = NodeQuestion(movie, False)
        else:
            if category != "":
                tmp = self.currentQuestion.copy(self.currentQuestion)
                self.currentQuestion.question = category_q
                self.currentQuestion.isQuestion = True
                self.currentQuestion.yes = NodeQuestion(question, True)
                self.currentQuestion.category = category
                current_p = self.currentQuestion
                self.currentQuestion = self.currentQuestion.yes
                if answer == 'y':
                    self.currentQuestion.yes = NodeQuestion(movie, False)
                else:
                    self.currentQuestion.no = NodeQuestion(movie, False)
                self.currentQuestion = current_p
                self.currentQuestion.no = tmp
            else:
                tmp_p = self.currentQuestion.copy(self.currentQuestion)
                self.currentQuestion.question = question
                self.currentQuestion.isQuestion = True
                self.memorize(answer, tmp_p, movie)

    def memorize(self, answer, temp, movie):
        if answer == 'y':
            self.currentQuestion.yes = NodeQuestion(movie, False)
            self.currentQuestion.no = temp
        else:
            self.currentQuestion.no = NodeQuestion(movie, False)
            self.currentQuestion.yes = temp


# This will only be present in the beginning
def welcome():
    upper_screen = "Hi World!"
    lower_screen = "____GUESS MY MOVIE GAME____"
    return lower_screen, upper_screen


# Lets play starts playing the game
def lets_play(brain):
    while True:
        brain.ask()
        answer = input()
        if answer == 'x':
            print("Exiting the game")
        won = brain.if_won(answer)
        if won == 'y':
            print("I Know Everything ^_^")
            break
        elif won == 'c':
            if answer == 'y':
                brain.next_question(True)
            elif answer == 'n':
                brain.next_question(False)
        else:
            learn(brain, answer)
            break


def learn(brain, answer):
    print("We learn much from defeat!...\nWhat is your movie's name?")
    name_movie = input()
    print("What Question would you ask about this movie?")
    question = input()
    global learned_answer
    global learned_category
    learned_answer = ""
    while True:
        print("How would you reply to that?\nY: yes	N:no")
        learned_answer = input()
        if learned_answer == 'y' or learned_answer == 'n':
            break
        else:
            print("Please choose provided character")
    learned_category = ""
    if not brain.currentQuestion.category == "" and not answer == 'y':
        print("What is the category of the movie?")
        learned_category = input()
    brain.learn(name_movie, question, learned_answer, learned_category, answer)
    print("Learnt!")


# A prompt screen for the user
def prompt():
    print("Click x to Exit")
    print("Press P to Play")
    print("Press v to view")
    print("Press s to save")
    print("Press l to load")


# The start method that calls all the necessary methods
def start():
    end = 0
    brain = Memory()
    brain.beginning("Is it an animation movie?", "animation")
    while end == 0:
        prompt()
        choice = input()
        if choice == 'x':
            end = 1
        elif choice == 'p':
            lets_play(brain)
            brain.currentQuestion = brain.firstQuestion
        elif choice == 'v':
            pprint_tree(brain.firstQuestion, 0)
        elif choice == 's':
            save(brain)
        elif choice == 'l':
            brain = load()


def pprint_tree(root, level):
    if root is None:
        return
    pprint_tree(root.yes, level + 1)
    if level != 0:
        for x in range(level - 1):
            print("|\t")
        print("|-------" + root.question)
    else:
        print(root.question)
    pprint_tree(root.no, level + 1)


def save(obj):
    pickle_out = open("movies.pickle", "wb")
    pickle.dump(obj, pickle_out)
    pickle_out.close()


def load():
    pickle_in = open("movies.pickle", "rb")
    obj = pickle.load(pickle_in)
    return obj


start()
