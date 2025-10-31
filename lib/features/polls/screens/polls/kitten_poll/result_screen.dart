import 'package:flutter/material.dart';
import '../../../widgets/rating_review_screen.dart';

class ResultScreen extends StatelessWidget {
  final int totalScore;
  final String pollId;
  final String pollTitle;
  final String pollCategory;

  const ResultScreen({
    super.key,
    required this.totalScore,
    required this.pollId,
    required this.pollTitle,
    required this.pollCategory,
  });

  Map<String, dynamic> _getResult() {
    if (totalScore <= 0) {
      return {
        'text': 'СОННЫЙ КОТЕНОК! 🐱‍💤',
        'description': 'Твой главный девиз сегодня: "Не трогай меня, человек". '
            'Ты ищешь уединения, теплой лежанки и полного покоя. '
            'Лучший вечер — это когда тебя никто не беспокоит. '
            'Отдохни и наберись сил, завтра будет новый день!'
      };
    } else if (totalScore <= 4) {
      return {
        'text': 'КОТЕНОК-НЕВЕДИМКА! 🐱‍👤',
        'description': 'Ты мастерски балансируешь между общением и уединением. '
            'Ты где-то тут, но ненадолго. Ты не против компании, '
            'но и одиноко тебе не бывает. Ты плывешь по течению дня, '
            'сохраняя загадочное спокойствие и независимость.'
      };
    } else if (totalScore <= 8) {
      return {
        'text': 'ИГРИВЫЙ И ЛЮБОЗНАТЕЛЬНЫЙ КОТЕНОК! 🐱‍🚀',
        'description': 'Мир полон загадок, и ты жаждешь их разгадать! '
            'Сегодня ты полон энергии, готов к новым открытиям и приключениям '
            '(даже если это просто новый маршрут до работы). '
            'Твое любопытство — твой главный проводник. Не забудь поиграть!'
      };
    } else {
      return {
        'text': 'ДОБРЫЙ И СОЦИАЛЬНЫЙ КОТЕНОК! 🥰',
        'description': 'Ты просто лучик солнца в пушистой шкурке! '
            'Тебе хочется мурлыкать, ластиться ко всем и дарить хорошее настроение. '
            'Ты открыт к общению, готов помочь и просто заряжаешь всех вокруг '
            'своей позитивной энергией. Поделись своим теплом с миром!'
      };
    }
  }

  void _navigateToRatingReview(BuildContext context, String resultText) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RatingReviewScreen(
          pollId: pollId,
          pollTitle: pollTitle,
          pollCategory: pollCategory,
          pollResult: resultText,
          onComplete: () {
            // Возвращаемся на главный экран после сохранения
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = _getResult();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Результат"),
        backgroundColor: Colors.blue[700],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Поздравляем!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.pets,
                size: 100,
                color: Colors.blue[700],
              ),
              const SizedBox(height: 20),
              Text(
                "Сегодня ты ${result['text']}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                result['description'],
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _navigateToRatingReview(context, result['text']),
                  child: const Text(
                    "Оценить опрос",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    // Пропускаем оценку и сразу возвращаемся на главную
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "Завершить без оценки",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}