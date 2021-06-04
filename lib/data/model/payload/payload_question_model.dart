import 'package:satorio/data/model/payload/payload_answer_option_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';

class PayloadQuestionModel extends PayloadQuestion implements ToJsonInterface {
  const PayloadQuestionModel(
    String questionId,
    String questionText,
    int timeForAnswer,
    int totalQuestions,
    int questionNumber,
    List<PayloadAnswerOption> answerOptions,
  ) : super(questionId, questionText, timeForAnswer, totalQuestions,
            questionNumber, answerOptions);

  factory PayloadQuestionModel.fromJson(Map json) => PayloadQuestionModel(
        json['question_id'] == null ? '' : json['question_id'],
        json['question_text'] == null ? '' : json['question_text'],
        json['time_for_answer'] == null ? 0 : json['time_for_answer'],
        json['total_questions'] == null ? 0 : json['total_questions'],
        json['question_number'] == null ? 0 : json['question_number'],
        (json['answer_options'] == null ||
                !(json['answer_options'] is Iterable))
            ? []
            : (json['answer_options'] as Iterable)
                .where((element) => element != null)
                .map((element) => PayloadAnswerOptionModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'question_id': questionId,
        'question_text': questionText,
        'time_for_answer': timeForAnswer,
        'total_questions': totalQuestions,
        'question_number': questionNumber,
        'answer_options': answerOptions
            .where((element) => element is ToJsonInterface)
            .map((element) => (element as ToJsonInterface).toJson())
            .toList(),
      };
}